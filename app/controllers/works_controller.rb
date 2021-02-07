class WorksController < ApplicationController
  def index
  end

  def show
    
  end

  def new
    @work = Work.new
    @request = Request.find(params[:request_id])
    @applies = @request.applies
  end

  def create
    user = User.find_by(params[:worker_id])
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
