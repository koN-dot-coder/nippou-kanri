class CalendarsController < ApplicationController
  before_action :require_manager!

  def show
    start_date = params.fetch(:start_date, Date.current).to_date
    range = start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week
    reports = current_user.visible_daily_reports.where(report_date: range)
    @submitted_counts = reports.group(:report_date).count
    @attention_counts = reports/where(needs_attention: true).group(:report_date).count
    @member_count = current_user.team.users.member.count
  end
end
