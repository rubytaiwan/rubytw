class AddColumnApplyToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :need_apply, :boolean
  end
end
