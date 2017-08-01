class AddColumnActiveToCommunity < ActiveRecord::Migration[5.0]
  def change
    add_column :communities, :active, :boolean
  end
end
