class DailyReportsController < ApplicationController
  before_action :require_manager!, only: %i[index toggle_attention]
  before_action :require_member!, only: %i[new create edit update]
def index
     @date = params[:date].present? ? Date.parse(params[:date]) : Date.current
    @reports = current_user.visible_daily_reports
                           .where(report_date: @date).includes(:user).for_summary
    @missing_users = current_user.team.users.member.where.not(id: @reports.map(&:user_id))
end
  def show
    @daily_report = current_user.visible_daily_reports.find(params[:id])
  end

  def new
    existing = current_user.daily_reports.find_by(report_date: Date.current)
    return redirect_to(existing.draft? ? edit_daily_report_path(existing) : existing) if existing

    @daily_report = current_user.daily_reports.build(report_date: Date.current)
  end

  def create
    @daily_report = current_user.daily_reports.build(daily_report_params)
    @daily_report.status = params[:draft] ? :draft : :submitted

    if @daily_report.save
      redirect_after_save
    else
      render :new, status: :unprocessable_entity
    end
  end


  def edit
    @daily_report = current_user.daily_reports.draft.find(params[:id])
  end


  def update
    @daily_report = current_user.daily_reports.draft.find(params[:id])
    @daily_report.assign_attributes(daily_report_params)
    @daily_report.status = params[:draft] ? :draft : :submitted

    if @daily_report.save
      redirect_after_save
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def toggle_attention
    @daily_report = current_user.visible_daily_reports.find(params[:id])
    @daily_report.update!(needs_attention: !@daily_report.needs_attention)
    redirect_back fallback_location: daily_report_path(@daily_report)
  end


  private

  def redirect_after_save
    if @daily_report.draft?
      redirect_to edit_daily_report_path(@daily_report), notice: "下書きを保存しました"
    else
      redirect_to @daily_report, notice: "日報を提出しました"
    end
  end

  def daily_report_params
    params.require(:daily_report).permit(:report_date, :done, :trouble, :plan, :condition)
  end
end
