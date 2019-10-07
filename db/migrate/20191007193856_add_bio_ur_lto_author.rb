class AddBioUrLtoAuthor < ActiveRecord::Migration[5.2]
  def change
    remove_column :books, :bio_url
    add_column :authors, :bio_url, :string
  end
end
