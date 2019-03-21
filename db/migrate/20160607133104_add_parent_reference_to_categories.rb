class AddParentReferenceToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :parent_id, :integer

  end
end
