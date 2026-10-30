class CalendarsController < ApplicationController
  before_action :require_manager!
  # TODO(B-6): 月の提出数・要確認数を集計する
  def show
    @submitted_counts = {}
    @attention_counts = {}
    @member_count = 0
  end
end
