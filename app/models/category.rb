class Category < ActiveRecord::Base
    has_many :subcategories, :class_name => "Category", :foreign_key => "parent_id", :dependent => :destroy
    belongs_to :parent_category, :class_name => "Category"
    validates :name, presence: true, length: {minimum: 3, maximum: 25}
    validates_uniqueness_of :name
end