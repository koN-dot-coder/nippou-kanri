class My::DailyReportsController < ApplicationController
  before_action :require_member!
  # TODO(B-7): 自分の日報を新しい日付順に取得する
  def index
   @daily_reports =
  DailyReport.none
 end
end
