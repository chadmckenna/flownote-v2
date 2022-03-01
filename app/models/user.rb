class User < ApplicationRecord
  before_create :set_username
  validates :username, presence: true, uniqueness: true

  has_many :notes, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :folders, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def get_share_url(url)
    uri = URI(url)

    routes = Rails.application.routes.url_helpers
    share_urls = notes.shared.map do |shared|
      {
        url: routes.note_path(shared),
        share_url: routes.share_path(user: username, slug: shared.slug)
      }
    end

    if ['localhost', 'flownote.app', '2.flownote.app'].include?(uri.host)
      found = share_urls.find{ |s| s[:url] == uri.path }
      found[:share_url] if found
    end
  end

  private
  def set_username
    if username.blank?
      self.username = SecureRandom.alphanumeric(6)
    end
  end
end
