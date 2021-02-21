class UsersController < ApplicationController
  before_action :require_user_logged_in, only:[:show]
  
  def show
    @user = User.find(params[:id])
    @done_works = current_user.workings.where(status: 2)
    @finish_works = current_user.requests.where(status: 2)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザーを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザーの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'プロフィールを編集しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'プロフィールを編集できませんでした。'
      render :show
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :content, :image)
  end
end
