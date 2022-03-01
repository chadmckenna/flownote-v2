class Note < ApplicationRecord
  broadcasts
  belongs_to :user
  has_many :tags, dependent: :destroy
  has_one :history, dependent: :destroy

  scope :shared, -> { where(public: true) }

  before_create :set_slug
  before_update :append_to_history, if: -> { will_save_change_to_attribute? :content }
  before_save :set_tags

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

  def append_to_history
    diff = Diffy::Diff.new(
      content_change_to_be_saved.first,
      content_change_to_be_saved.last,
      context: 1,
      include_plus_and_minus_in_html: true
    ).to_s(:html)

    diff.prepend "<time datetime='#{updated_at.to_json}'>Updated at: #{updated_at}</time>"

    if history
      history.content_diff.prepend diff
      history.save
    else
      history = History.create(note_id: id, content_diff: diff)
    end
  end

  def set_slug
    loop do
      self.slug = SecureRandom.alphanumeric(6)
      break unless Note.where(slug: slug).exists?
    end
  end
end
