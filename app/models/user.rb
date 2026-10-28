class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable

  belongs_to :team

  has_many :daily_reports, dependent: :destroy

  enum :role, { member: 0, manager: 1 }

  validates :name, presence: true
end
