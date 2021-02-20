class WorksController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    @client_works = current_user.requests.where(status: 1)
    @worker_works = current_user.workings.where(status: 1)
    @done_works = current_user.workings.where(status: 2)
  end

  def show
    @work = Work.find(params[:id])
    @talk = current_user.talks.build
    @talks = @work.talks.where(status: 0).or(@work.talks.where(status: 3)).order(id: :asc).page(params[:page])
    @talk_report = @work.talks.where(status: 1)
    @talk_resubmit = @work.talks.where(status: 2)
    if !@talk_resubmit.empty? && current_user.id == @work.worker_id
      flash[:warning] = '修正依頼が届いています。修正後に再度報告をしてください。'
    end
    if !@talk_report.empty? && current_user.id != @work.worker_id && @work.request.status == 1
      flash[:warning] = '作業報告が届いています。確認をお願いします。'
    end
  end

  def new
    #@work = Work.new
    @request = Request.find(params[:request_id])
    @applies = @request.applies
    if current_user.id == @request.client_id
      @work = @request.works.build
    end
  end

  def create
    user = User.find(params[:worker_id])
    @request = Request.find(params[:request_id])
    @request.status = 1
    @work = user.works.build(request_id: @request.id)
    if @request.deadline
      @work.deadline = @request.deadline
    end
    if @work.save && @request.save
      flash[:success] = '担当者を決定しました。'
      redirect_to @work
    else
      flash.now[:danger] = '担当者の選択に失敗しました。'
      render :new
    end
  end
  
  def edit
    @work = Work.find(params[:id])
    @talk = Talk.find(params[:talk_id])
  end
  
  def content
    @work = Work.find(params[:id])
  end
  
  def report
    @work = Work.find(params[:id])
    @talk = current_user.talks.build
  end
  
  def confirm
    @work = Work.find(params[:id])
    @talk = @work.talks.where(status: 1)
    @resubmit = current_user.talks.build
    @worker_evaluation = WorkerEvaluation.new
  end
  
  def done
    @work = Work.find(params[:id])
    @worker_evaluation = @work.worker_evaluations
    @client_evaluation = ClientEvaluation.new
  end
  
end