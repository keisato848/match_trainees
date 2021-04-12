class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @trainings = Training.where("start_at > ?", Time.zone.now).order(:start_at)
  end
end
