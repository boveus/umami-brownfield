class User < ApplicationRecord
  has_secure_password
  validates_presence_of :name, :email, :address, :password
  validates_uniqueness_of :name, :email
  has_many :orders
  has_many :user_roles
  has_many :roles, through: :user_roles
  belongs_to :vendor, optional: true

  enum role: [:default, :admin, :business_manager]

  def business_admin?
    roles.exists?(name: "budiness_admin")
  end

  def self.find_or_create_from_auth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.image = auth.info.image
      user.address = "123 ABC St"
      user.password = 'n/a'
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save
    end
  end
end
