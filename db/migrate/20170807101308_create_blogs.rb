class CreateBlogs < ActiveRecord::Migration[5.0]
  def change
    create_table :blogs do |t|
      t.string :title
      t.date :date_of_news
      t.text :content
      t.boolean :active

      t.timestamps
    end
  end
end
