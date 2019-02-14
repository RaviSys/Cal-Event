class Guest < ApplicationRecord
  belongs_to :event, optional: true
  validates :email, presence: true
end
