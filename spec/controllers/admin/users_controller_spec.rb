require 'spec_helper'

describe Admin::UsersController do
  let(:user) { Factory.create(:user) }

  describe "GET index" do
    it "assigns all admin_users as @users" do
      user2 = Factory.create(:user)
      get :index
      assigns(:users).should eq([user2])
    end
  end

  describe "GET show" do
    it "assigns the requested user as @user" do
      get :show, :id => user.id
      assigns(:user).should eq(user)
    end
  end

  describe "GET new" do
    it "assigns a new user as @user" do
      get :new
      assigns(:user).should be_a_new(User)
    end
  end

  describe "GET edit" do
    it "assigns the requested user as @user" do
      get :edit, :id => user.id
      assigns(:user).should eq(user)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new User" do
        expect {
          post :create, :user => Factory.attributes_for(:user)
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, :user => Factory.attributes_for(:user)
        assigns(:user).should be_a(User)
        assigns(:user).should be_persisted
      end

      it "redirects to the created user" do
        post :create, :user => Factory.attributes_for(:user)
        response.should redirect_to(admin_user_path(User.last))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        post :create, :user => {}
        assigns(:user).should be_a_new(User)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        post :create, :user => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested user" do
        # Assuming there are no other users in the database, this
        # specifies that the User created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        User.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => user.id, :user => {'these' => 'params'}
      end

      it "assigns the requested user as @user" do
        put :update, :id => user.id, :user => Factory.attributes_for(:user)
        assigns(:user).should eq(user)
      end

      it "redirects to the user" do
        put :update, :id => user.id, :user => Factory.attributes_for(:user)
        response.should redirect_to(admin_user_path(user))
      end
    end

    describe "with invalid params" do
      it "assigns the user as @user" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        put :update, :id => user.id, :user => {}
        assigns(:user).should eq(user)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        put :update, :id => user.id, :user => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested user" do
      user3 = Factory.create(:user)
      expect {
        delete :destroy, :id => user3.id
      }.to change(User, :count).by(-1)
    end

    it "redirects to the admin_users list" do
      delete :destroy, :id => user.id
      response.should redirect_to(admin_users_url)
    end
  end

end
