class My::DailyReportsController < ApplicationController
  before_action :require_member!

  def index
    @daily_reports = current_user.daily_reports.order(report_date: :desc)
  end
end
