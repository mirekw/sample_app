require 'spec_helper'

describe "LayoutLinks" do

  it "Should have home paga at '/'" do
    get '/'
    response.should render_template('pages/home')
  end

  it "Sould have a Contact page at '/contact'" do
    get '/contact'
    response.should render_template('pages/contact')
  end

  it "Should have a About page at '/about'" do
    get '/about'
    response.should render_template('pages/about')
  end

  it "Should have a Help page at '/help'" do
    get '/help'
    response.should render_template('pages/help')
  end

  it "Should have a Sign up at '/signup'" do
    get '/signup'
    response.should render_template('users/new')
  end

  it "Should have the right links on pages" do
    visit root_path
    click_link "About"
    response.should render_template('pages/about')
    click_link "Contact"
    response.should render_template('pages/contact')
    click_link "Home"
    response.should render_template('pages/home')
    click_link "Sign up"
    response.should render_template('users/new')
    click_link "Help"
    response.should render_template('pages/help')

  end

  describe "when not signed in" do
    it "should have a signin link" do
      visit root_path
      response.should have_tag("a[href=?]",signin_path,"Login")
    end
  end

  describe "when signed in" do
    before(:each) do
      @user = Factory(:user)
      integration_sign_in(@user)
    end

    it "should have a sing out link" do
      visit root_path
      response.should have_tag("a[href=?]",signout_path,"Logout")
    end

    it "should have a profile link" do
      visit root_path
      response.should have_tag("a[href=?]",user_path(@user),"Profile")
    end
  end
end