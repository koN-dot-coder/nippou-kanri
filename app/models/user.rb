class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable

  belongs_to :team

  has_many :daily_reports, dependent: :destroy

  enum :role, { member: 0, manager: 1 }

  validates :name, presence: true

  def visible_daily_reports
    manager? ? team.daily_reports.submitted : daily_reports
  end
end
