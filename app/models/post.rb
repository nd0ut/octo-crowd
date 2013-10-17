class Post < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  has_and_belongs_to_many :categories

  state_machine :moderation_state, :initial => :waiting do
    state :waiting
    state :accepted
    state :rejected

    event :accept do
      transition any => :accepted
    end

    event :deny do
      transition any => :rejected
    end
  end
end
