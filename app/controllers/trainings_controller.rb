class TrainingsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  def new
    @training = Training.new
  end

  def create
    @training = Training.new(training_params)
    if @training.save
      redirect_to training_path(@training)
    else
      render :new
    end
  end

  def show
    @training = Training.find(params[:id])
  end

  def edit
    @training = current_user.created_trainings.find(params[:id])
  end

  def update
    @training = current_user.created_trainings.find(params[:id])
    redirect_to @training if @training.update(training_params)
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
