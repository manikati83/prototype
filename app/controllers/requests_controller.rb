class RequestsController < ApplicationController
  def index
    @requests = current_user.requests.order(id: :desc).page(params[:page])
    
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
    if @request.save
      flash[:success] = "依頼を作成しました。"
      redirect_to requests_path
    else
      flash.now[:danger] = "依頼を作成できませんでした。"
      render :new
    end
  end

  def destroy
  end
  
  private
  
  def request_params
    params.require(:request).permit(:title, :content, :days)
  end
end
