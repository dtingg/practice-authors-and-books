class Book < ApplicationRecord
  belongs_to :author
  
  validates :title, presence: true
  
  validates :publication_date, presence: true
  
  def self.alpha_books
    return Book.order(title: :asc)
  end
end
