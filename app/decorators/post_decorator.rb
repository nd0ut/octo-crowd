require 'rubygems'
require 'sanitize'

class PostDecorator < Draper::Decorator
  delegate_all

  def read_next_link(options = {})
    options = { label: "Read next", with_icon: true }.merge(options)

    h.link_to h.post_url(object), class: 'btn btn-default btn-xs read-next' do
      text = "#{h.content_tag :div, nil, class: 'clearfix'}#{options[:label]}"
      icon = "&nbsp;&nbsp;#{h.content_tag :i, nil, class: 'icon-long-arrow-right'}"

      (text + "#{icon if options[:with_icon]}").html_safe
    end
  end

  def announce
    object.body.split(Post::CUT_HTML).first
  end

  def has_cut?
    object.body.include?(Post::CUT_HTML)
  end

  def body
    object.body.gsub(Post::CUT_HTML, '')
  end

  def time
    (updated_at.try(:localtime) || created_at.try(:localtime)).to_s
  end

  def search_fragments(query)
    return nil if query.nil?

    regex = /(?<=.| |)(([^.!?]+|)#{query}([^.!?]+|))(?=(|\s|\.|!|\?))/i

    matches = object.body.strip_tags.scan(regex)

    fragments = []

    matches.each_with_index do |m, i|
      fragments << m.join.strip
      fragments << '...' if i < matches.length - 1
    end

    fragments
  end

end