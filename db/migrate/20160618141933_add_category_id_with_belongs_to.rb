class AddCategoryIdWithBelongsTo < ActiveRecord::Migration
  def change
    add_column :merchandises, :category_id, :integer
  end
end
