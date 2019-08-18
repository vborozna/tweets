# frozen_string_literal: true
class User < ApplicationRecord
  devise :omniauthable, :rememberable, omniauth_providers: [:twitter]
  has_many :tweets

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid).permit!).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.oauth_token = auth.credentials.token
      user.oauth_secret = auth.credentials.secret
      user.save!
    end
  end
end
