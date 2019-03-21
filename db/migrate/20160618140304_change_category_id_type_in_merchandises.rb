class ChangeCategoryIdTypeInMerchandises < ActiveRecord::Migration[5.2]
  def change
    remove_column :merchandises, :category_id
  end
end
