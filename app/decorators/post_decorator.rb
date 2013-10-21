class PostDecorator < Draper::Decorator
  delegate_all

  def read_next_link(label = 'Read next')
    h.link_to label, h.post_url(object), class: 'btn btn-default btn-xs'
  end

  def announce
    object.body.split(Post::CUT_HTML).first
  end

  def body
    object.body.gsub(Post::CUT_HTML, '')
  end

  def time
    (updated_at.try(:localtime) || created_at.try(:localtime)).to_s
  end

end
