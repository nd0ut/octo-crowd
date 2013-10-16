module ApplicationHelper
  def session_provider
    provider = session['devise.user_attributes'].try(:[], 'provider')
    return nil unless provider

    provider.underscore.humanize.downcase
  end
end
