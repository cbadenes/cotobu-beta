class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
	  data = access_token.extra.raw_info
	  if admin = self.find_by_email(data.email)
	    admin
	  else # Create a admin with a stub password. 
	    self.create(:email => data.email, :password => Devise.friendly_token[0,20]) 
	  end
  end

  def self.new_with_session(params, session)
    super.tap do |admin|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        admin.email = data["email"]
      end
    end
  end

end
