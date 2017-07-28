class ChangeColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :events, :date_of_event, :start_date
  end
end
