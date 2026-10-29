class DailyReportsController < ApplicationController
  before_action :require_manager!, only: %i[index toggle_attention]
  before_action :require_member!, only: %i[new create edit update]
  def index; end
  def show
    @daily_report = current_user.visible_daily_reports.find(params[:id])
  end
  def new; end
  def create; end
  def edit; end
  def update; end
  def toggle_attention; end
end
