class WorkerEvaluationsController < ApplicationController
  before_action :set_twitter_client
  
  def index
  end

  def show
  end
  
  def create
    @tweet = params[:worker_evaluation][:tweet]

    @work = Work.find(params[:worker_evaluation][:work_id])
    request = @work.request
    request.status = 2
    user = User.find(@work.worker_id)
    @worker_evaluation = WorkerEvaluation.new(evaluation_params)
    @worker_evaluation.user_id = user.id
    if @worker_evaluation.save && request.save && @client.update(@tweet)
      flash[:success] = '評価しました。'
      redirect_to @work
    else
      flash[:danger] = '評価できませんでした。'
      redirect_back(fallback_location: root_path)
    end
  end
  
  private
  
  def evaluation_params
    params.require(:worker_evaluation).permit(:work_id, :content, :evaluation)
  end
  
  
  # def twitter_client
  #   @client = Twitter::REST::Client.new do |config|
  #     config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
  #     config.consumer_secret = ENV['TWITTER_SECRET_KEY']
  #     config.access_token = ENV['ACCESS_TOKEN']
  #     config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
  #   end
  # end
  
  def set_twitter_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_SECRET_KEY']
      config.access_token        = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end
  end
end
