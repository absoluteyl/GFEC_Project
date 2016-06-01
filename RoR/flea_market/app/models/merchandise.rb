class Merchandise < ActiveRecord::Base
    belongs_to :user
    validates :user_id, presence: true
    validates :title, presence: true, length: { minimum: 3, maximum: 50}
    validates :description, presence: true, length: { minimum: 10, maximum: 300}
    validates :price, presence: true, numericality: { only_integer: true }
    validates :amount, presence: true, numericality: { only_integer: true }
end