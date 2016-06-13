class AddMerchandiseImages < ActiveRecord::Migration
  def change
      add_attachment :merchandises, :merchandise_img_1
      add_attachment :merchandises, :merchandise_img_2
      add_attachment :merchandises, :merchandise_img_3
  end
end
