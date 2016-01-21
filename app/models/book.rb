class Book < ActiveRecord::Base
  has_and_belongs_to_many :authors

  has_many :reviews
  has_attached_file  :image, styles: { medium: "400x600#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
