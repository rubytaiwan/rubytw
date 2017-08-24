class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :title
      t.date :date_of_event
      t.string :location
      t.date :start_at
      t.date :end_at
      t.time :start_time
      t.time :end_time
      t.text :description
      t.string :apply_link
      t.boolean :active

      t.timestamps
    end
  end
end
