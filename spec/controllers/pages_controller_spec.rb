require 'spec_helper'

describe PagesController do
  integrate_views
  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end

    it "should have the right title" do
      get 'home'
      response.should have_tag("title",
                               "Test application | Home")
    end

  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end

    it "should have the riht title" do
      get 'contact'
      response.should have_tag('title',
                             "Test application | Contact")
    end
  end

  describe "GET 'about'" do
    it  "should be seccessful" do
      get 'about'
      response.should be_success
    end

    it "should have the right title" do
      get 'about'
      response.should have_tag('title',
                               "Test application | About")

    end
  end
end
