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
          fill_in "Password_confirmation",  :with => "password"
          click_button
          response.should have_tag("div.flash.success")
        end.should change(User, :count).by(1)
      end
    end

  end
end
