require 'rubygems'
require 'sanitize'

class Post < ActiveRecord::Base
  acts_as_commentable

  default_scope -> { order('created_at DESC') }

  belongs_to :author, class_name: 'User'
  has_and_belongs_to_many :categories

  validates :title, presence: true,
                    length: { minimum: 3, maximum: 140 }

  validates :categories,  presence: true,
                          length: { minimum: 1, maximum: 3 }

  before_save :sanitize_html
  before_save :remove_unnecessary_cuts

  def sanitize_html
    self.title = Sanitize.clean(title, Sanitize::Config::POST)
    self.body  = Sanitize.clean(body, Sanitize::Config::POST)
  end

  def remove_unnecessary_cuts
    cut_html = '<cut></cut>'

    cut_num = 0
    self.body = body.gsub(cut_html) do |match|
      cut_num = cut_num + 1
      cut_num == 1 ? match : ""
    end
  end

  state_machine :moderation_state, :initial => :waiting do
    state :waiting
    state :accepted
    state :rejected

    event :accept do
      transition any => :accepted
    end

    event :reject do
      transition any => :rejected
    end
  end
end
