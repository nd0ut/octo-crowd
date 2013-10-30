require 'rubygems'
require 'sanitize'

class Post < ActiveRecord::Base
  acts_as_commentable
  acts_as_taggable

  default_scope -> { order('created_at DESC') }

  belongs_to :author, class_name: 'User'
  has_and_belongs_to_many :categories
  has_many :comments, foreign_key: 'commentable_id', dependent: :destroy
  has_many :subscriptions, through: :categories

  validates :title, presence: true,
                    length: { minimum: 3, maximum: 140 }

  validates :body, presence: true,
                    length: {
                      minimum: 3,
                      tokenizer: lambda { |str| str.strip_tags.scan(/\[^ ,.!?\]+/) },
                      too_short: "must have at least %{count} words",
                      too_long:  "must have at most %{count} words"
                    }


  validates :categories,  presence: true,
                          length: { minimum: 1, maximum: 3 }

  validates :tag_list, presence: true,
                       length: { minimum: 1, maximum: 10 }

  before_save :sanitize_html
  before_save :remove_unnecessary_cuts

  def sanitize_html
    self.title = Sanitize.clean(title, Sanitize::Config::POST)
    self.body  = Sanitize.clean(body, Sanitize::Config::POST)
  end

  CUT_HTML = '<cut></cut>'

  def remove_unnecessary_cuts
    cut_num = 0
    self.body = body.gsub(CUT_HTML) do |match|
      cut_num = cut_num + 1
      cut_num == 1 ? match : ""
    end
  end

  state_machine :moderation_state, initial: :waiting do
    state :waiting
    state :accepted
    state :rejected

    event :accept do
      transition any => :accepted
    end

    event :reject do
      transition any => :rejected
    end

    after_transition waiting: :accepted do |post|
      UserMailer.delay.post_accepted(post)
    end

    after_transition waiting: :rejected do |post|
      UserMailer.delay.post_rejected(post)
    end

    after_transition waiting: :accepted do |post|
      subscriptions = post.subscriptions.includes(:user).uniq

      subscriptions.each do |s|
        UserMailer.delay.announce_post(s.user, post)
      end
    end
  end
end
