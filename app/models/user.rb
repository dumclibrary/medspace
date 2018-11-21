class User < ApplicationRecord

  if Blacklight::Utils.needs_attr_accessible?
    attr_accessible :email, :password, :password_confirmation
  end
  # Connects this user object to Blacklights Bookmarks.
  include Blacklight::User
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Connects this user object to Hydra behaviors.
  include Hydra::User
  # Connects this user object to Role-management behaviors.
  include Hydra::RoleManagement::UserRoles


  # Connects this user object to Hyrax behaviors.
  include Hyrax::User
  include Hyrax::UserUsageStats

  INSTITUTION_PRINCIPAL_NAME_SCOPE = 'duke.edu'

  if Blacklight::Utils.needs_attr_accessible?
    attr_accessible :email, :password, :password_confirmation
  
  # Method added by Blacklight; Blacklight uses #to_s on your
  # user class to get a user-displayable login/identifier for
  # the account.
  def to_s
    email
  end
end
  # Connects this user object to Blacklights Bookmarks.
  include Blacklight::User
  include Hydra::RoleManagement::UserRoles
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :omniauthable,
         :rememberable,
         :trackable,
         :validatable,
         omniauth_providers: [:shibboleth]

  validates :uid, presence: true, uniqueness: true

  class << self
    # @param auth [OmniAuth::AuthHash] authenticated user information.
    # @return [User] the authenticated user, possibly a newly created record.
    def from_omniauth(auth)
      find_or_initialize_by(uid: auth.uid).tap do |user|
        # set a random (unusable) password for a new user
        user.password = Devise.friendly_token if user.new_record?
    
        # set/update attributes based on our omniauth-shibboleth authentication mapping
        # see https://github.com/omniauth/omniauth/wiki/Auth-Hash-Schema
        user.update!(email: auth.info.email, display_name: auth.info.name)
      
  # Method added by Blacklight; Blacklight uses #to_s on your
  # user class to get a user-displayable login/identifier for
  # the account.
  def to_s
    email
  end
end
    end	

    def find_or_create_system_user(user_key)
      User.find_by_user_key(user_key) ||
        User.create!(Hydra.config.user_key_field => user_key,
                     email: user_key,
                     password: Devise.friendly_token[0, 20])
    
  # Method added by Blacklight; Blacklight uses #to_s on your
  # user class to get a user-displayable login/identifier for
  # the account.
  def to_s
    email
  end
end
  
  # Method added by Blacklight; Blacklight uses #to_s on your
  # user class to get a user-displayable login/identifier for
  # the account.
  def to_s
    email
  end
end
  # Method added by Blacklight; Blacklight uses #to_s on your
  # user class to get a user-displayable login/identifier for
  # the account.
  def to_s
    email || uid 
  
  # Method added by Blacklight; Blacklight uses #to_s on your
  # user class to get a user-displayable login/identifier for
  # the account.
  def to_s
    email
  end
end
  
  def user_key
    uid
  
  # Method added by Blacklight; Blacklight uses #to_s on your
  # user class to get a user-displayable login/identifier for
  # the account.
  def to_s
    email
  end
end

  # For Duke users, returns the (unscoped) NetID
  # For non-Duke users, returns nil
  def netid
    username, scope = user_key.split('@')
    username if scope == INSTITUTION_PRINCIPAL_NAME_SCOPE
  
  # Method added by Blacklight; Blacklight uses #to_s on your
  # user class to get a user-displayable login/identifier for
  # the account.
  def to_s
    email
  end
end

  # Method added by Blacklight; Blacklight uses #to_s on your
  # user class to get a user-displayable login/identifier for
  # the account.
  def to_s
    email
  end
end
