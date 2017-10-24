class User < ApplicationRecord
  has_secure_password
  has_secure_token
  validates_presence_of :name, :email, :address, :password
  validates_uniqueness_of :name, :email
  has_many :orders
  has_many :user_roles
  has_many :roles, through: :user_roles
  belongs_to :vendor, optional: true

  enum role: [:default, :admin, :business_manager]

  def top_level_role
    top_role = roles
    .where(permission_level: roles.select('MAX(permission_level)'))
    .first
    if top_role
      return top_role.name
    else
      return "default"
    end
  end

  def business_manager?
    roles.exists?(name: "business_manager")
  end

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
    end
  end

  def invalidate_token
    self.update_columns(token: nil)
  end

  def self.valid_login?(email, password)
    user = find_by(email: email)
    if user && user.authenticate(password)
      user
    end
  end
end
