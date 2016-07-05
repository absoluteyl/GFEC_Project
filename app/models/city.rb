class City < ActiveRecord::Base
    has_many :locations
    has_many :districts, :class_name => "City", :foreign_key => "parent_id", :dependent => :destroy
    belongs_to :parent_city, :class_name => "City"
    validates :name, presence: true
end