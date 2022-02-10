class Note < ApplicationRecord
  broadcasts
  has_many :tags, dependent: :destroy

  before_save :set_tags

  def to_html
    Redcarpet::Markdown.new(
      CustomMarkdown::CustomHTML.new({ prettify: true }),
      {
        autolink: true,
        no_intra_emphasis: true,
        tables: true,
        strikethrough: true,
        space_after_headers: true,
        fenced_code_blocks: true
      }
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
    tags << to_add.map{|n| Tag.new(name: n)}
  end
end
