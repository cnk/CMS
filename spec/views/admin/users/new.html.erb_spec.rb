require 'spec_helper'

describe "admin/users/new.html.erb" do
  before(:each) do
    assign(:user, stub_model(User).as_new_record)
  end

  it "renders new user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => admin_users_path, :method => "post" do
      assert_select "input#user_login", :name => "user[login]"
      assert_select "input#user_first_name", :name => "user[first_name]"
      assert_select "input#user_last_name", :name => "user[last_name]"
      assert_select "input#user_email", :name => "user[email]"
      assert_select "input#user_password", :name => "user[password]"
      assert_select "input#user_password_confirmation", :name => "user[password_confirmation]"
    end
  end
end
