class ToppagesController < ApplicationController
  def index
    @requests = Request.order(id: :desc).page(params[:page])
  end
end
