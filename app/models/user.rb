class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable

  belongs_to :team

  enum :role, { member: 0, manager: 1 }

  validates :name, presence: true
end
