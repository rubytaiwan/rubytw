# frozen_string_literal: true

class SEO
  attr_accessor :title, :description, :url, :image, :type

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value) if respond_to?("#{name}=")
    end
  end

  def to_meta
    {
      title: title,
      description: description
    }
  end

  def to_google
    {
      name: title,
      description: description,
      image: image
    }
  end

  def to_open_graph
    {
      title: title,
      description: description,
      image: image,
      url: url,
      type: type
    }
  end
end
