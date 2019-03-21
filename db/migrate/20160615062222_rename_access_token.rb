class RenameAccessToken < ActiveRecord::Migration[5.2]
  def change
    rename_column :api_keys, :access_token, :api_key
  end
end
