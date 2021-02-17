class TalksController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    if params[:status_id] == "0"
      work = Work.find(params[:work_id])
      @talk = current_user.talks.build(talk_params)
      @talk.work_id = work.id
    elsif params[:status_id] == "1"
      work = Work.find(params[:work_id])
      @talk = current_user.talks.build(talk_params)
      @talk.work_id = work.id
      @talk.status = 1
    else
      work = Work.find(params[:work_id])
      @talk = current_user.talks.build(talk_params)
      @talk.work_id = work.id
      @report = work.talks.where(status: 1)
      @report.first.status = 2
      @talk.status = 3
      @report.first.save
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
    @talk = Talk.find(params[:id])
    @talk.status = 1
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
