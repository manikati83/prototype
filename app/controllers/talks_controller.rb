class TalksController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    if params[:status_id] == '0'
      work = Work.find(params[:work_id])
      @talk = current_user.talks.build(talk_params)
      @talk.work_id = work.id
    else
      work = Work.find(params[:work_id])
      @talk = current_user.talks.build(talk_params)
      @talk.work_id = work.id
      @talk.status = 1
    end
    if @talk.save
      flash[:success] = 'メッセージを送りました。'
      redirect_to work_path(work)
    else
      flash.now[:danger] = 'メッセージを送れませんでした。'
      redirect_back(fallback_location: works_path)
    end
  end
  
  def update
    work = Work.find(params[:work_id])
    @talk = Talk.find(params[:talk_id])
    if @talk.update(talk_params)
      flash[:success] = 'メッセージを送りました。'
      redirect_to work_path(work)
    else
      flash.now[:danger] = 'メッセージを送れませんでした。'
      redirect_back(fallback_location: works_path)
    end
  end

  def destroy
  end
  
  private
  
  def talk_params
    params.require(:talk).permit(:content)
  end
end
