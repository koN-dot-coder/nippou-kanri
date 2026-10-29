class Team < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :daily_reports, through: :users

  validates :name, presence: true
end
