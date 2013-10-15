module ApplicationHelper
  def session_provider
    session['devise.user_attributes'].try(:[], 'provider')
  end
end
