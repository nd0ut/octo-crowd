module ApplicationHelper
  def session_provider
    provider = session['devise.user_attributes'].try(:[], 'provider')
    return nil unless provider

    provider.underscore.humanize.downcase
  end

  def icon_with_label(label, icon_class, label_options = nil)
    "<i class=\"#{icon_class}\"></i>&nbsp;&nbsp;#{content_tag :span, label, label_options}</a>".html_safe
  end

  def label_with_icon(label, icon_class)
    "#{label}&nbsp;&nbsp;<i class=\"#{icon_class}\"></i>".html_safe
  end

  def callout_type(level_for)
    types = %w[danger warning info]

    type_num = level_for

    if type_num > types.length - 1
      type_num = type_num / types.length
    end

    types[type_num]
  end

end
