class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale, :set_seo

  def set_seo(options={})
    @seo = {
      meta: {
        site: t('landing.site'),
        title: t('landing.site'),
        description: t('landing.description')
      },
      google: {
        name: t('landing.site'),
        description: t('landing.description'),
        image: 'og_image.png'
      },
      og: {
        title: t('landing.title'),
        description: t('landing.description'),
        image: 'og_image.png',
        url: request.url,
        type: :website
      },
      twitter: {
        card: "summary",
        site: "@rubytaiwan"
      }
    }

    options.reverse_merge!(@seo)

  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
