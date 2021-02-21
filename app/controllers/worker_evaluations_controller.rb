class WorkerEvaluationsController < ApplicationController
  before_action :set_twitter_client
  
  def index
    redirect_to works_path
  end

  def show
  end
  
  def create
    @tweet = params[:worker_evaluation][:tweet]

    @work = Work.find(params[:worker_evaluation][:work_id])
    @talk_report = @work.talks.where(status: 1)
    request = @work.request
    request.status = 2
    user = User.find(@work.worker_id)
    @worker_evaluation = WorkerEvaluation.new(evaluation_params)
    @worker_evaluation.user_id = user.id
    if @tweet.length >= 70
      @resubmit = current_user.talks.build
      flash[:danger] = 'ツイートできる文字数を超えています。'
      return redirect_to confirm_work_path(@work.id)
    end
    if @worker_evaluation.save && request.save && @client.update(@tweet)
      flash[:success] = '評価しました。'
      redirect_to @work
    else
      @resubmit = current_user.talks.build
      flash[:danger] = @worker_evaluation.errors.full_messages
      redirect_to confirm_work_path(@work.id)
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
