require 'rubygems'
require 'sanitize'

class Post < ActiveRecord::Base
  acts_as_commentable

  default_scope -> { order('created_at DESC') }

  belongs_to :author, class_name: 'User'
  has_and_belongs_to_many :categories

  before_save :sanitize_html

  validates :title, presence: true,
                    length: { minimum: 3, maximum: 140 }

  validates :categories,  presence: true,
                          length: { minimum: 1, maximum: 2 }


  def sanitize_html
    self.title = Sanitize.clean(title, Sanitize::Config::SPECIAL)
    self.body  = Sanitize.clean(body, Sanitize::Config::SPECIAL)
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
