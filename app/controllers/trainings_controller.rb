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

  private
  
  def training_params
    params.require(:training).permit(:name, :prefecture_id, :place ,:start_at, :end_at, :content).merge(owner_id: current_user.id)
  end
end
