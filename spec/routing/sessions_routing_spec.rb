require "spec_helper"

describe Devise::SessionsController do
  describe "routing" do

    it "routes to #sign_in" do
      get("/users/sign_in").should route_to("devise/sessions#new")
    end

    it "puts form to #sign_in" do
      post("/users/sign_in").should route_to("devise/sessions#create")
    end

    it "routes to #sign_out" do
      get("/users/sign_out").should route_to("devise/sessions#destroy")
    end

  end
end
