class CreateCommunities < ActiveRecord::Migration[5.0]
  def change
    create_table :communities do |t|
      t.string :name
      t.string :link
      t.string :type

      t.timestamps
    end
  end
end
