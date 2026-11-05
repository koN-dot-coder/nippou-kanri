class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  before_action :authenticate_user!

  private

  def require_manager!
    redirect_to root_path, alert: "上司のみ見られる画面です" unless current_user.manager?
  end

  def require_member!
    redirect_to root_path, alert: "部下のみ使える画面です" unless current_user.member?
  end

  def after_sign_in_path_for(user)
    user.manager? ? calendar_path : my_daily_reports_path
  end

  def after_sign_out_path_for(_resource)
    new_user_session_path
  end
end
