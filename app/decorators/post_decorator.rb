require 'rubygems'
require 'sanitize'

class PostDecorator < Draper::Decorator
  delegate_all

  def read_next_link(label = 'Read next')
    h.link_to h.post_url(object), class: 'btn btn-default btn-xs read-next' do
      "#{label}&nbsp;&nbsp;#{h.content_tag :i, nil, class: 'icon-long-arrow-right'}".html_safe
    end
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
    return nil if query.nil

    fragments = object.body.strip_tags.scan(/(?<=)([^.!?]+#{query}[^.!?]+)(?=(\.|!|\?))/)
    return nil if fragments.nil?

    linked_body = ''

    fragments.each_with_index do |f, i|
      linked_body << f.join.strip
      linked_body << '...'
    end

    linked_body.empty? ? nil : linked_body
  end

end

class String
  def strip_tags
     ActionController::Base.helpers.strip_tags(self)
  end
end