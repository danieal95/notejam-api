class User < ApplicationRecord
  has_many :pads
  has_many :notes
  validates :email, presence: true
  validates :password, presence: true
end
