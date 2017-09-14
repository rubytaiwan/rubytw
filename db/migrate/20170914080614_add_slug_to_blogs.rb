class AddSlugToBlogs < ActiveRecord::Migration[5.0]
  def change
    add_column :blogs, :slug, :string
  end
end
