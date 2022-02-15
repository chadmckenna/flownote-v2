class User < ApplicationRecord
  before_create :set_username
  validates :username, presence: true, uniqueness: true

  has_many :notes, dependent: :destroy
  has_many :tags, dependent: :destroy

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
