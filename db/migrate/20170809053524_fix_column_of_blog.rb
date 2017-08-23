class FixColumnOfBlog < ActiveRecord::Migration[5.0]
  def up
    remove_column :blogs, :show
    change_column :blogs, :active, :boolean, :default => true
  end

  def down
    change_column :blogs, :active, :boolean, :default => true
  end
end
