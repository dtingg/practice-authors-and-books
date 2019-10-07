class PublicationDate < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :publication_date, :integer
  end
end
