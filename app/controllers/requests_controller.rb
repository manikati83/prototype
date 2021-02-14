class RequestsController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    @requests = current_user.requests
    @requests = @requests.where(status: 0).order(id: :desc).page(params[:page])
  end

  def show
    @request = Request.find(params[:id])
    @apply = Apply.new
  end

  def new
    @request = current_user.requests.build
    @apply = Apply.new
  end

  def create
    @request = current_user.requests.build(request_params)
    today = Date.today
    if @request.apply_days && @request.deadline
      if @request.apply_days > @request.deadline
        flash.now[:danger] = "納品期限が不正です。"
        return render :new
      elsif @request.apply_days <= today
        flash.now[:danger] = "応募期限が過ぎています。"
        return render :new
      end
    elsif @request.apply_days
      if @request.apply_days <= today
        flash.now[:danger] = "応募期限が過ぎています。"
        return render :new
      end
    else
      flash.now[:danger] = '応募期限を指定してください。'
      return render :new
    end
    
    if @request.save
      flash[:success] = "依頼を作成しました。"
      redirect_to requests_path
    else
      flash.now[:danger] = "依頼を作成できませんでした。"
      render :new
    end
  end

  def destroy
    @request = Request.find(params[:id])
    @request.destroy
    flash[:success] = '依頼を取り消しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def request_params
    params.require(:request).permit(:title, :content, :apply_days, :deadline)
  end
end
