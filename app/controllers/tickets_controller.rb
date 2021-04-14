class TicketsController < ApplicationController
  def create
    training = Training.find(params[:training_id])
    @ticket = current_user.tickets.build do |t|
      t.training = training
      t.comment = params[:comment]
    end
    if @ticket.save
      redirect_to training_path(params[:training_id])
    else
      @training = Training.find(params[:training_id])
      render template: 'trainings/show'
    end
  end
end
