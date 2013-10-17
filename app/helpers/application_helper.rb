module ApplicationHelper
  def session_provider
    provider = session['devise.user_attributes'].try(:[], 'provider')
    return nil unless provider

    provider.underscore.humanize.downcase
  end

  def icon_with_label(label, icon_class)
    "<i class=\"#{icon_class}\"></i>&nbsp; &nbsp;#{label}</a>".html_safe
  end

  def label_with_icon(label, icon_class)
    "#{label}&nbsp;&nbsp;<i class=\"#{icon_class}\"></i>".html_safe
  end

end
