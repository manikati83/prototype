class TalksController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    redirect_to works_path
  end
  
  def show
    @talk = Talk.find(params[:id])
    @work = @talk.work
    redirect_to @work
  end
  
  def create
    if params[:status_id] == "0"
      @work = Work.find(params[:work_id])
      
      @talk = current_user.talks.build(talk_params)
      @talk.work_id = @work.id
    elsif params[:status_id] == "1"
      @work = Work.find(params[:work_id])
      @talk = current_user.talks.build(talk_params)
      @talk.work_id = @work.id
      @talk.status = 1
      if @talk.save
        flash[:success] = 'メッセージを送りました。'
        return redirect_to work_path(@work)
      else
        @talk_report = @work.talks.where(status: 1)
        @talk_resubmit = @work.talks.where(status: 2)
        @talks = @work.talks.where(status: 0).or(@work.talks.where(status: 3)).order(id: :asc).page(params[:page])
        flash.now[:danger] = 'メッセージを送れませんでした。'
        return render template: "works/report"
      end
    else
      @work = Work.find(params[:work_id])
      @resubmit = current_user.talks.build(talk_params)
      @resubmit.work_id = @work.id
      @talk_report = @work.talks.where(status: 1)
      @talk_report.first.status = 2
      @resubmit.status = 3
    end
    if @resubmit
      if @resubmit.save && @talk_report.first.save
        flash[:success] = 'メッセージを送りました。'
        redirect_to work_path(@work)
      else
        @worker_evaluation = WorkerEvaluation.new
        flash.now[:danger] = '修正内容を入力してください。'
        render template: "works/confirm"
      end
      
    elsif @talk.save
      flash[:success] = 'メッセージを送りました。'
      redirect_to work_path(@work)
    else
      @talk_report = @work.talks.where(status: 1)
      @talk_resubmit = @work.talks.where(status: 2)
      @talks = @work.talks.where(status: 0).or(@work.talks.where(status: 3)).order(id: :asc).page(params[:page])
      flash.now[:danger] = 'メッセージを送れませんでした。'
      render template: "works/show"
    end
  end
  
  def update
    @work = Work.find(params[:work_id])
    @talk = Talk.find(params[:id])
    @talk.status = 1
    if @talk.update(talk_params)
      flash[:success] = 'メッセージを送りました。'
      redirect_to work_path(@work)
    else
      flash.now[:danger] = 'メッセージを送れませんでした。'
      render template: "works/report"
    end
  end

  def destroy
  end
  
  private
  
  def talk_params
    params.require(:talk).permit(:content)
  end
end
