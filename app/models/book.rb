class Book < ApplicationRecord
  belongs_to :author
  has_and_belongs_to_many :genres
  
  validates :title, presence: true
  
  validates :publication_date, presence: true
  
  def self.alpha_books
    return Book.order(title: :asc)
  end
end
