class WorksController < ApplicationController
  def index
    @client_works = current_user.requests.where(status: 1)
    @worker_works = current_user.works
  end

  def show
    @work = Work.find(params[:id])
    @talks = @work.talks.order(id: :desc).page(params[:page])
  end

  def new
    @work = Work.new
    @request = Request.find(params[:request_id])
    @applies = @request.applies
  end

  def create
    user = User.find(params[:worker_id])
    request = Request.find(params[:request_id])
    request.status = 1
    @work = user.works.build(request_id: request.id)
    today = Date.today
    deadline = today + request.days
    @work.deadline = deadline
    if @work.save && request.save
      flash[:success] = '担当者を決定しました。'
      redirect_to @work
    else
      flash.now[:danger] = '担当者の選択に失敗しました。'
      render :new
    end
  end
end
