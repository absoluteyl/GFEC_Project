class RenameMerchandiseImages < ActiveRecord::Migration[5.2]
  def change
      rename_column :merchandises, :merchandise_img_1_file_name, :image_1_file_name
      rename_column :merchandises, :merchandise_img_1_file_size, :image_1_file_size
      rename_column :merchandises, :merchandise_img_1_content_type, :image_1_content_type
      rename_column :merchandises, :merchandise_img_1_updated_at, :image_1_updated_at

      rename_column :merchandises, :merchandise_img_2_file_name, :image_2_file_name
      rename_column :merchandises, :merchandise_img_2_file_size, :image_2_file_size
      rename_column :merchandises, :merchandise_img_2_content_type, :image_2_content_type
      rename_column :merchandises, :merchandise_img_2_updated_at, :image_2_updated_at

      rename_column :merchandises, :merchandise_img_3_file_name, :image_3_file_name
      rename_column :merchandises, :merchandise_img_3_file_size, :image_3_file_size
      rename_column :merchandises, :merchandise_img_3_content_type, :image_3_content_type
      rename_column :merchandises, :merchandise_img_3_updated_at, :image_3_updated_at
  end
end
