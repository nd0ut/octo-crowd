class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :async

  devise :omniauthable, :omniauth_providers => [:facebook, :vkontakte, :twitter, :github]

  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_one :subscription, dependent: :destroy

  after_create :create_subscription


  def add_subscription_to(category)
    self.subscription.categories << category
  end

  def remove_subscription_from(category)
    self.subscription.categories.delete(category)
  end

  def has_subscription_to?(category)
    self.subscription.categories.select { |cat| cat.id == category.id }.present?
  end


  def access_token
    User.verifier.generate(self.id)
  end

  def self.read_access_token(signature)
    begin
      id = User.verifier.verify(signature)
      User.find_by_id id
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      nil
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid.to_s).first_or_initialize do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname.present? ? auth.info.nickname : auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def self.new_with_session(params, session)
    if session['devise.user_attributes']
      new(session['devise.user_attributes']) do |user|
        user.attributes = params
        user.password = Devise.friendly_token[0,20]
      end
    else
      super
    end
  end

  private
  def create_subscription
    Subscription.create(user_id: self.id) if subscription.nil?
  end

  def self.verifier
    @verifier ||= ActiveSupport::MessageVerifier.new(OctoCrowd::Application.config.secret_key_base)
  end
end
