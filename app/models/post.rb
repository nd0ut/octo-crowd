class Post < ActiveRecord::Base
  acts_as_commentable

  belongs_to :author, class_name: 'User'
  has_and_belongs_to_many :categories

  validates :title, presence: true,
                    allow_blank: false,
                    length: { minimum: 3, maximum: 140 }

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
