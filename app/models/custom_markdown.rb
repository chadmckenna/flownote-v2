module CustomMarkdown
  DEFAULTS = {
    autolink: true,
    no_intra_emphasis: true,
    tables: true,
    strikethrough: true,
    space_after_headers: true,
    fenced_code_blocks: true
  }

  class CustomHTML < Redcarpet::Render::HTML
    def list_item(text, list_type)
      if text.start_with?("[x]", "[X]")
        text[0..2] = %(<input type="checkbox" checked="checked" disabled>)
        %(<li><s>#{text}</s></li>)
      elsif text.start_with?("[ ]")
        text[0..2] = %(<input type="checkbox" disabled>)
        %(<li>#{text}</li>)
      else
        %(<li>#{text}</li>)
      end
    end

    def paragraph(text)
      text.gsub!(Tag::TAG_REGEX, '<kbd><a href="/notes/by_tag/\1">#\1</a></kbd>')
      return %(<p>#{text}</p>)
    end

    def block_code(code, language)
      if language.eql? 'mermaid'
        return %(<div class="mermaid">%%{init: {'theme':'dark'}}%%\n#{code}</div>)
      else
        lang = language ? "language-#{language}" : ""
        return %(<pre class="#{lang}"><code>#{ERB::Util.html_escape(code)}</code></pre>)
      end
    end

    def image(link, title, alt_text)
      img_src = %(<img src="#{link}" title="#{title}" alt="#{alt_text}">)

      if link =~ /^(.+?)\s*=+(\d+)(?:px|)$/
        # e.g. ![alt](url.png =100px)
        # e.g. ![alt](url.png =100)
        img_src = %(<img src="#{$1}" style="max-width: #{$2}px" alt="#{alt_text}">)
      elsif link =~ /^(.+?)\s*=+(\d+)(?:px|)x(\d+)(?:px|)$/
        # e.g. ![alt](url.png =30x50)
        img_src = %(<img src="#{$1}" style="max-width: #{$2}px; max-height: #{$3}px;" alt="#{alt_text}">)
      end

      %(<div><div>#{img_src}</div><div>#{alt_text}</div></div>)
    end
  end

  class CustomShareHTML < CustomHTML
    def initialize(options, share_user)
      @share_user = share_user
      super options
    end

    def paragraph(text)
      text.gsub!(Tag::TAG_REGEX, "<kbd><a href='/~#{@share_user.username}/by_tag/\\1'>#\\1</a></kbd>")
      return %(<p>#{text}</p>)
    end
  end
end
