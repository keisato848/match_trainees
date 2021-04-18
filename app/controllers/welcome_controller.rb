class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @trainings = Training.page(params[:page]).per(10)
                         .where('start_at > ?', Time.zone.now).order(:start_at)
    # 検索用のインスタンス
    @t = Training.ransack(params[:q])
    @prefecture_name = Prefecture.all
  end
end
