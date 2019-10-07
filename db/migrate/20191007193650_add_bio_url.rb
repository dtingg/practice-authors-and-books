class AddBioUrl < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :bio_url, :string
  end
end
