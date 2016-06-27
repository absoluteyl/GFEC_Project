class Location < ActiveRecord::Base
    belongs_to :user
    validates :user_id, presence: true
    validates :lat, presence: true
    validates :long, presence: true
end