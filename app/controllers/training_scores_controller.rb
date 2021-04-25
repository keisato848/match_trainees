class TrainingScoresController < ApplicationController
  before_action :set_user
  before_action :correct_user
  before_action :set_training, only: [:edit, :update, :destroy]

  def new
    @training_score = TrainingScore.new
  end

  def create
    @training_score = TrainingScore.new(training_score_params)
    if @training_score.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @training_score.update(training_score_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    if @training_score.destroy
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def correct_user
    redirect_to root_path unless user_signed_in? && current_user.id == params[:user_id].to_i
  end

  def set_training
    @training_score = TrainingScore.find_by(user_id: @user.id)
  end

  def training_score_params
    params.require(:training_score).permit(:bench_press_weight, :squat_weight, :deadlift_weight).merge(user_id: @user.id)
  end
end
