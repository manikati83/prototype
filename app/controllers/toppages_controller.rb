class ToppagesController < ApplicationController
  def index
    if logged_in?
      @requests = Request.order(id: :desc).page(params[:page])
    end
  end
end
