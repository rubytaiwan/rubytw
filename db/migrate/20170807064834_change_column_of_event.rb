class ChangeColumnOfEvent < ActiveRecord::Migration[5.0]
  def up
    rename_column :events, :start_at, :start_on
    rename_column :events, :end_at, :end_on
    change_column :events, :end_on, :date, after: :end_at
    change_column :events, :need_apply, :boolean, before: :active
  end
end
