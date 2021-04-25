class UsersController < ApplicationController
  before_action :set_user
  before_action :correct_user, only: [:edit, :update]

  def show
    @training_score = TrainingScore.find_by(user_id: @user.id)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: '登録情報を更新しました'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def correct_user
    redirect_to root_path unless user_signed_in? && current_user == @user
  end

  def user_params
    params.fetch(:user, {}).permit(:email, :name, :provider, :uid, :image_url, :image)
  end
end
