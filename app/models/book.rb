class Book < ActiveRecord::Base
  searchkick
  has_and_belongs_to_many :authors

  has_many :reviews
  has_attached_file  :image
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def get_average_rating
    @reviews = Review.where(book_id: self.id)
    if @reviews.blank?
      return  0
    else
      return @reviews.average(:rating).round(2)
    end
  end
end
