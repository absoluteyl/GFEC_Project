class RenameAccessToken < ActiveRecord::Migration
  def change
    rename_column :api_keys, :access_token, :api_key
  end
end
