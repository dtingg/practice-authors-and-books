class Book < ApplicationRecord
  belongs_to :author
  validates :title, presence: true
  
  def self.alpha_books
    return Book.order(title: :asc)
  end
end
