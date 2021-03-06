class TrainingsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @trainings = Training.page(params[:page]).per(12)
                         .where('start_at > ?', Time.zone.now).order(:start_at)
  end

  def new
    @training = Training.new
  end

  def create
    @training = Training.new(training_params)
    if @training.save
      redirect_to training_path(@training), notice: 'トレーニングを作成しました'
    else
      render :new
    end
  end

  def show
    @training = Training.find(params[:id])
    @ticket = current_user.tickets.find_by(training: @training) if user_signed_in?
    @tickets = @training.tickets.includes(:user).order(:created_at)
  end

  def edit
    @training = current_user.created_trainings.find(params[:id])
  end

  def update
    @training = current_user.created_trainings.find(params[:id])
    redirect_to @training, notice: 'トレーニング内容を更新しました' if @training.update(training_params)
  end

  def destroy
    @training = current_user.created_trainings.find(params[:id])
    @training.destroy!
    redirect_to root_path
  end

  private

  def training_params
    params.require(:training).permit(:name, :image, :remove_image, :prefecture_id, :place, :start_at, :end_at,
                                     :content).merge(owner_id: current_user.id)
  end
end
