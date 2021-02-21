class ClientEvaluationsController < ApplicationController
  def index
    redirect_to works_path
  end

  def show
  end
  
  def create
    @work = Work.find(params[:client_evaluation][:work_id])
    user = User.find(@work.request.client_id)
    @client_evaluation = ClientEvaluation.new(evaluation_params)
    @client_evaluation.user_id = user.id
    if @client_evaluation.save
      flash[:success] = '評価しました。'
      redirect_to @work
    else
      @worker_evaluation = @work.worker_evaluations
      flash[:danger] = @client_evaluation.errors.full_messages
      redirect_to done_work_path(@work.id)
    end
  end
  
  private
  
  def evaluation_params
    params.require(:client_evaluation).permit(:work_id, :content, :evaluation)
  end
end
