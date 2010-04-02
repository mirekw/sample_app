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
    click_link "Help"
    response.should render_template('pages/help')
    click_link "Sign up"
    response.should render_template('users/new')
  end

end
