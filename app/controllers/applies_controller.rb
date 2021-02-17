class AppliesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @request = Request.find(params[:request_id])
    apply = current_user.applies.build(apply_params)
    apply.request_id = @request.id
    if apply.save
      flash[:success] = '応募しました。'
      redirect_to @request
    else
      flash[:danger] = '応募できませんでした。'
      redirect_to @request
    end
  end

  def destroy
    @request = Request.find(params[:request_id])
    current_user.unapply(@request)
    flash[:success] = '応募を取り消しました。'
    redirect_to @request
  end
  
  private
  
  def apply_params
    params.require(:apply).permit(:content)
  end
end
