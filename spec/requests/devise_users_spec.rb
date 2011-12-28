require 'spec_helper'

describe "Devise::Sessions" do
  describe "GET /users/sign_in" do
    it "should display a form for login and password" do
      get new_user_session_path
      response.status.should be(200)

      assert_select "form", :action => user_session_path, :method => "post" do
        assert_select "input#user_login", :name => "user[login]"
        assert_select "input#user_password", :name => "user[password]"
      end
    end
  end
end
