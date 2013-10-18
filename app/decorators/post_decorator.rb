class PostDecorator < Draper::Decorator
  delegate_all

  def time
    (updated_at.try(:localtime) || created_at.try(:localtime)).to_s
  end

end
