class Location < ActiveRecord::Base
  belongs_to :user
  belongs_to :city
  has_many :merchandises, through: :users
  validates :user_id, presence: true
  validates :lat, presence: true
  validates :long, presence: true
end