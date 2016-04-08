class User < ActiveRecord::Base
  def self.find_or_create_from_auth_hash(auth_hash)
    return User.find_or_create_by(google_uid: auth_hash[:uid],
                                  name: auth_hash[:info][:name],
                                  first_name: auth_hash[:info][:first_name],
                                  last_name: auth_hash[:info][:last_name],
                                  email: auth_hash[:info][:email])
  end
end
