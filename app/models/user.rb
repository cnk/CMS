class User < ActiveRecord::Base
  # Include the following devise modules. Others available are:
  # :registerable, :recoverable :token_authenticatable, :encryptable, :confirmable, 
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :email, :password, :password_confirmation
end
