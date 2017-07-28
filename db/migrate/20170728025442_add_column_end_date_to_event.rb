class AddColumnEndDateToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :end_date, :date
  end
end
