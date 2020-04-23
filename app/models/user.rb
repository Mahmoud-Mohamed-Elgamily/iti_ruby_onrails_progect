class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many:activites
  has_many:groups
  has_many:orderdetails
  has_many :friendships, foreign_key: :friend_id, class_name: 'Friendship'
  has_many :friends, through: :friendships


  #my order info hazem
  has_many:notifications
  has_many:orders, through: :notifications

  devise :omniauthable, :omniauth_providers => [:facebook,:google_oauth2]
  # devise :rememberable, :omniauthable, omniauth_providers: []

  # verify your schema for the additional fields/columns
  def self.new_with_session(params, session)
    super.tap do |user|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank? end
      end
    end
    def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
    end
  end
end
