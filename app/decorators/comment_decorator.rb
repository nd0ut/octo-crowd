class CommentDecorator < Draper::Decorator
  delegate_all

  decorates_association :children

  def author_name
    object.user.try(:username) || 'anonymous'
  end

  def time
    (updated_at.try(:localtime) || created_at.try(:localtime)).to_s
  end
end
