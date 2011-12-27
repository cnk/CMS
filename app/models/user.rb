class User < ActiveRecord::Base
  # Include the following devise modules. Others available are:
  # :registerable, :recoverable :token_authenticatable, :encryptable, :confirmable, 
  # :lockable, :timeoutable, :validatable and :omniauthable
  devise :database_authenticatable, :recoverable, :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :login, :email, :password, :password_confirmation

  # validation - CNK decided it was easier to do my own than override devise validations
  validates :first_name, :presence => true, :length => {:maximum => 255}
  validates :last_name, :presence => true, :length => {:maximum => 255}
  validates :login, :presence => true, :uniqueness => true, 
            :length => {:maximum => 255, :minimum => 2}
  validates :email, :presence => true, :uniqueness => true, :length => {:maximum => 255},
            :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
  
  validates_presence_of     :password, :if => :password_required?
  validates_confirmation_of :password, :if => :password_required?
  validates_length_of       :password, :within => 6..128, :allow_blank => true

  protected 

    # Stolen from Devise lib/devise/models/validatable.rb
    # Checks whether a password is needed or not. For validations only.
    # Passwords are always required if it's a new record, or if the password
    # or confirmation are being set somewhere.
    def password_required?
      !persisted? || !password.blank? || !password_confirmation.blank?
    end
end
