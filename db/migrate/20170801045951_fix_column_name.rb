class FixColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :communities, :type, :community_type
  end
end
