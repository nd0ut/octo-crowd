require 'rubygems'
require 'sanitize'

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

  def search_fragment(query)
    fragments = object.body.scan(/(?<=)([^.!?]+#{query}[^.!?]+)(?=(\.|!|\?))/)
    return nil if fragments.nil?

    linked_body = ''

    fragments.each_with_index do |f, i|
      linked_body << f.join.strip
      linked_body << '...'
    end

    linked_body = Sanitize.clean(linked_body)

    linked_body.html_safe
  end

end
