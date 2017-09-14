module ApplicationHelper
  def markdown(text)
    options = {
      filter_html: true,
      hard_wrap: true,
      link_attributes: { target: "_blank" },
      space_after_headers: true,
      fenced_code_blocks: true,
      prettify: true
    }

    extensions = {
      autolink: true,
      superscript: true,
      highlight: true,
      no_intra_emphasis: true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end

  def home_page_loaded?
    request.path == root_path || request.headers['HTTP_TURBOLINKS_REFERRER'].present?
  end

  def page_title
    [content_for(:title), t('landing.site')].compact.join(' | ')
  end

  def page_description
    content_for(:description) || t('landing.description')
  end

  def page_image
    content_for(:image) || image_url('og_image.png')
  end

  def page_type
    return :website if request.path == root_path
    :article
  end
end
