class DailyReport < ApplicationRecord
  belongs_to :user

  SUMMARY_LENGTH = 60
  LOW_CONDITION = 2

  enum :status, { draft: 0, submitted: 1 }

  validates :report_date, presence: true, uniqueness: { scope: :user_id }
  validates :condition, inclusion: { in: 1..5 }, allow_nil: true
  validates :done, :plan, :condition, presence: true, if: :submitted?
  before_save :mark_submitted, if: -> { will_save_change_to_status?(to: "submitted") }

  # 一覧の並び：要確認が上、その中は提出が早い順
  scope :for_summary, -> { order(needs_attention: :desc, submitted_at: :asc) }

  # 要約（MVPは「やったこと」の先頭。本リリースでAI要約に差し替える）
  def summary
    done.to_s.truncate(SUMMARY_LENGTH)
  end

  # 要確認のルール判定
  def auto_attention?
    trouble.present? || condition.to_i <= LOW_CONDITION
  end

  # 一覧・詳細に出す「印の理由」
  def attention_reasons
    reasons = []
    reasons << "困りごとあり" if trouble.present?
    reasons << "調子が低め" if condition.to_i <= LOW_CONDITION
    reasons.presence || [ "上司がつけた印" ]
  end

  private

  # 提出した瞬間に1回だけ動く。上司の手動切り替えはこの後なので上書きされない
  def mark_submitted
    self.submitted_at = Time.current
    self.needs_attention = auto_attention?
  end
end
