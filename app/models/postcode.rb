class Postcode < ActiveRecord::Base
    has_many :districts, :class_name => "Postcode", :foreign_key => "city_id", :dependent => :destroy
    belongs_to :city_postcode, :class_name => "Postcode"
    validates :name, presence: true
end