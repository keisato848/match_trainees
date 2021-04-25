class TicketsController < ApplicationController
  def create
    training = Training.find(params[:training_id])
    @ticket = current_user.tickets.build do |t|
      t.training = training
      t.comment = params[:comment]
    end
    if @ticket.save
      redirect_to training_path(params[:training_id]), notice: '参加処理が完了しました'
    else
      @training = Training.find(params[:training_id])
      @tickets = @training.tickets.includes(:user).order(:created_at)
      render template: 'trainings/show'
    end
  end

  def destroy
    ticket = current_user.tickets.find_by!(training_id: params[:training_id])
    ticket.destroy!
    redirect_to training_path(params[:training_id]), notice: '参加をキャンセルしました'
  end
end
