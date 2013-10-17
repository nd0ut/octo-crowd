class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  devise :omniauthable, :omniauth_providers => [:facebook, :vkontakte]

  has_many :posts, foreign_key: 'author_id', dependent: :destroy

  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid.to_s).first_or_initialize do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname.present? ? auth.info.nickname : auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end

    user
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
end
