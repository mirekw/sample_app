require 'spec_helper'

describe "Users" do

  describe "signup" do

    describe "failure" do
      it "should not make a new user" do
        lambda do
          visit root_path
          click_link "Sign up"
          click_button
          response.should render_template('users/new')
          response.should have_tag("div#errorExplanation")
        end.should_not change(User, :count)
      end
    end
    describe "success" do
      it "should make a new user" do
        lambda do
          visit root_path
          click_link "Sign up"
          fill_in "Name",                   :with => "Test user"
          fill_in "Email",                  :with => "test@domena.pl"
          fill_in "Password",               :with => "password"
          fill_in "Password confirmation",  :with => "password"
          click_button
          response.should have_tag("div.flash.success")
        end.should change(User, :count).by(1)
      end
    end
  end

  describe "sign in/out" do

    describe "failure" do
      it "should not sign a user in" do

        user = Factory.build(:user)
        integration_sign_in(user)
        response.should render_template('sessions/new')
        response.should have_tag("div.flash.error", /invalid/i)
      end
    end

    describe "success" do
      it "should sign a user in and out" do
        user = Factory(:user)
        integration_sign_in(user)
        controller.should be_signed_in
        click_link "Logout"
        controller.should_not be_signed_in
      end
    end
  end
end
