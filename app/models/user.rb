class User < ApplicationRecord
  before_create :set_username
  validates :username, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  private
  def set_username
    if username.blank?
      self.username = SecureRandom.alphanumeric(6)
    end
  end
end
