# frozen_string_literal: true

module SeoHelper
  def seo_meta_tags
    capture do
      meta_tags(seo.to_meta)
      og_meta_tags(seo.to_open_graph)
      google_meta_tags(seo.to_google)
      twitter_meta_tags
    end
  end

  private

  # http://ogp.me/
  def og_meta_tags(options = {})
    meta_tags(options) do |name, value|
      tag(:meta, property: "og:#{name}", content: value)
    end
  end

  # http://schema.org/
  def google_meta_tags(options = {})
    meta_tags(options) do |name, value|
      tag(:meta, itemprop: name, content: value)
    end
  end

  def twitter_meta_tags(options = {})
    default = {
      card: 'summary',
      site: '@rubytaiwan'
    }

    meta_tags(default.merge(options)) do |name, value|
      tag(:meta, name: "twitter:#{name}", content: value)
    end
  end

  def meta_tags(**hash, &_block)
    hash.each do |name, value|
      if block_given?
        concat yield(name, value)
      else
        concat tag(:meta, name: name, content: value)
      end
    end
  end

  def seo
    @seo ||= SEO.new(
      title: page_title,
      description: page_description,
      image: page_image,
      url: request.url,
      type: page_type
    )
  end
end
