require 'spec_helper'

describe User do
  subject { Factory(:user) }
  # validation checking
  it { should validate_presence_of(:login) }
  it { should validate_uniqueness_of(:login) }
  it { should ensure_length_of(:login).is_at_least(2) }
  it { should ensure_length_of(:login).is_at_most(255) }

  it { should validate_presence_of(:first_name) }
  it { should ensure_length_of(:first_name).is_at_most(255) }

  it { should validate_presence_of(:last_name) }
  it { should ensure_length_of(:last_name).is_at_most(255) }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should ensure_length_of(:email).is_at_most(255) }
  %w(jroe@caltech.edu jane.roe@gmail.com jrow@foo.example.com).each do |email| 
    it { should allow_value(email).for(:email) }
  end
  ["Jane Roe <jroe@caltech.edu>", "Jane Roe", "http://url.example.com"].each do |email| 
    it { should_not allow_value(email).for(:email) }
  end
  

  USER_FIELDS = %w(first_name last_name login email encrypted_password reset_password_token reset_password_sent_at sign_in_count current_sign_in_at last_sign_in_at current_sign_in_ip last_sign_in_ip password_salt failed_attempts locked_at created_at updated_at)

#   it "should have the specified fields:\n\t #{USER_FIELDS.join(', ')}" do
  it "should have the specified fields" do
    user = User.new
    for field in USER_FIELDS
      user.should respond_to(field)
    end
  end

  DB_FIELDS = User.columns.collect(&:name)
  MASS_ASSIGNABLE = %w(first_name last_name login email password password_confirmation)
  NOT_MASS_ASSIGNABLE = DB_FIELDS - MASS_ASSIGNABLE

  # it "should have very few mass_assignable fields:\n\t #{MASS_ASSIGNABLE.join(', ')}" do
  it "should have very few mass_assignable fields" do
    # Set up hash with values for all fields and create a user with that data
    fields = {:password => "value", :password_confirmation => "value"}
    DB_FIELDS.each{ |f| fields[f.to_sym] = "value" }
    user = User.new(fields)

    # check mass assignable fields retained their values
    for field in MASS_ASSIGNABLE
      user.send(field).should == "value"
    end
    
    # But fields that are not mass assignable, get changed to nil - or default values
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
