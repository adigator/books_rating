class User < ActiveRecord::Base
  has_secure_password
  has_many :reviews, dependent: :destroy
  def admin?
    self.role=='admin'
  end
end
