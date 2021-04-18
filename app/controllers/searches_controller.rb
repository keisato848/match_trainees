class SearchesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    t = Training.ransack(params[:q])
    @results = t.result.page(params[:page]).per(12)
                .where('start_at > ?', Time.zone.now).order(:start_at)
    q = params[:q]
    @searched_prefecture = Prefecture.find(q[:prefecture_id_eq])
  end
end
