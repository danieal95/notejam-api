class Note < ApplicationRecord
  belongs_to :pad
  belongs_to :user
  validates :name, presence: true
  validates :text, presence: true
end
