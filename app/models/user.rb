class User < ApplicationRecord
  has_secure_password
  validates_presence_of :name, :email, :address, :password
  validates_uniqueness_of :name, :email
  has_many :orders
  
  enum role: [:default, :admin]
  
  def self.find_or_create_from_auth(auth)
    find_or_create_by(provider: auth["provider"], uid: auth["uid"]) do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      if auth["info"]["email"]
        user.email = auth["info"]["email"]
      else
        user.email = "fake@twitter.com" 
      end
      user.image = auth["info"]["image"]
      user.address = "123 ABC St"
      user.password = 'n/a'
      user.oauth_token = auth["credentials"]["token"]
      user.oauth_expires_at = Time.at(auth["credentials"]["expires_at"]) if auth["credentials"]["expires_at"]
      user.save
      binding.pry
    end
  end
end
