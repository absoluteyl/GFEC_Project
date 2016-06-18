class ChangeCategoryIdTypeInMerchandises < ActiveRecord::Migration
  def change
    remove_column :merchandises, :category_id
  end
end
