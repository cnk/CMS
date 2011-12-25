require 'spec_helper'

describe User do
  USER_FIELDS = %w(login email encrypted_password reset_password_token reset_password_sent_at sign_in_count current_sign_in_at last_sign_in_at current_sign_in_ip last_sign_in_ip password_salt failed_attempts locked_at created_at updated_at)

  it "should have the specified fields:\n\t #{USER_FIELDS.join(', ')}" do
    user = User.new
    for field in USER_FIELDS
      user.should respond_to(field)
    end
  end

  MASS_ASSIGNABLE = %w(login email password password_confirmation)
  NOT_MASS_ASSIGNABLE = USER_FIELDS - MASS_ASSIGNABLE

  it "should have very few mass_assignable fields:\n\t #{MASS_ASSIGNABLE.join(', ')}" do
    # Set up hash with values for all fields and create a user with that data
    fields = {:password => "value", :password_confirmation => "value"}
    USER_FIELDS.each{ |f| fields[f.to_sym] = "value" }
    user = User.new(fields)

    # check mass assignable fields retained their values
    for field in MASS_ASSIGNABLE
      user.send(field).should == "value"
    end
    
    # But fields that are not mass assignable, get nill - or default values
    for field in NOT_MASS_ASSIGNABLE
      if  field == "encrypted_password"
        # encrypted_password gets filled in with a callback so skip it
      elsif ["sign_in_count", "failed_attempts"].include?(field)
        user.send(field).should == 0
      else
        user.send(field).should == nil 
      end
    end
  end

end
