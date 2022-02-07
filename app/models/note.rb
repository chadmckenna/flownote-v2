class Note < ApplicationRecord
  broadcasts

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
end
