class WorkerEvaluationsController < ApplicationController
  def index
  end

  def show
  end
  
  def create
    work = Work.find(params[:worker_evaluation][:work_id])
    user = User.find(work.worker_id)
    @worker_evaluation = WorkerEvaluation.new(evaluation_params)
    @worker_evaluation.user_id = user.id
    if @worker_evaluation.save
      flash[:success] = '評価しました。'
      redirect_to work
    else
      flash[:danger] = '評価できませんでした。'
      redirect_back(fallback_location: root_path)
    end
  end
  
  private
  
  def evaluation_params
    params.require(:worker_evaluation).permit(:work_id, :content, :evaluation)
  end
end
