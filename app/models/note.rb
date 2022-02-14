class Note < ApplicationRecord
  broadcasts
  belongs_to :user
  has_many :tags, dependent: :destroy

  before_save :set_tags
  before_create :set_slug

  def to_html
    Redcarpet::Markdown.new(
      CustomMarkdown::CustomHTML.new({ prettify: true }),
      CustomMarkdown::DEFAULTS
    )
      .render(content)
      .html_safe
  end

  def to_share_html
    Redcarpet::Markdown.new(
      CustomMarkdown::CustomShareHTML.new({ prettify: true }, user),
      CustomMarkdown::DEFAULTS
    )
      .render(content)
      .html_safe
  end

  def to_markdown
    "# #{title}\n\n#{content}"
  end

  private
  def set_tags
    return if content.nil?
    current_tag_names = tags.pluck(:name)
    updated_tag_names = content.scan(Tag::TAG_REGEX).flatten.uniq
    to_add = updated_tag_names - current_tag_names
    to_remove = current_tag_names - updated_tag_names
    tags.where(name: to_remove).destroy_all
    tags << to_add.map{|n| Tag.new(name: n, user: user)}
  end

  def set_slug
    loop do
      self.slug = SecureRandom.alphanumeric(6)
      break unless Note.where(slug: slug).exists?
    end
  end
end
