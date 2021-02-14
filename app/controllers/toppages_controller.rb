class ToppagesController < ApplicationController
  def index
    if logged_in?
      today = Date.today
      @requests = Request.where(status: 0)
      @requests = @requests.where("apply_days >= ?", today).order(id: :desc).page(params[:page])
    end
  end
end
