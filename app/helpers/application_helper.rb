module ApplicationHelper
  # 要確認の理由（attention_reasons）ごとのアイコン
  ATTENTION_REASON_ICONS = { "困りごとあり" => "icon-trouble", "調子が低め" => "icon-mood" }.freeze

  def attention_reason_icon(reason)
    ATTENTION_REASON_ICONS.fetch(reason, "icon-alert")
  end
end
