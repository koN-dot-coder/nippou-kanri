class DailyReportsController < ApplicationController
  before_action :require_manager!, only: %i[index toggle_attention]
  before_action :require_member!, only: %i[new create edit update]

  # TODO(B-4): 指定日の提出済み日報と未提出者を取得する
  def index
    @date = Date.current
    @reports = DailyReport.none
    @missing_users = User.none
  end

  def show
    @daily_report = current_user.visible_daily_reports.find(params[:id])
  end

  # TODO(B-3): 今日の分があれば、下書きなら編集・提出済みなら詳細へ移動する
  def new
    @daily_report = current_user.daily_reports.build(report_date: Date.current)
  end

  # TODO(B-3): 下書き保存・提出の処理を書く
  def create
    redirect_to my_daily_reports_path
  end

  # TODO(B-3): .draft を付けて、下書きだけ編集できるようにする
  def edit
    @daily_report = current_user.daily_reports.find(params[:id])
  end

  # TODO(B-3): 下書き保存・提出の処理を書く
  def update
    redirect_to my_daily_reports_path
  end

  # TODO(B-4): 要確認の印をつけ外しする
  def toggle_attention
    redirect_to daily_reports_path
  end
end
