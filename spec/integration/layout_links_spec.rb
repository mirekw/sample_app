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

end
