require 'spec_helper'

describe User do
  before(:each) do
    @valid_attributes = {
      :name => "Mirek",
      :email => "miron_w@o2.pl"
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@valid_attributes)
  end

  it "it should require a name" do
    no_user_name = User.new(@valid_attributes.merge(:name => ""))
    no_user_name.should_not be_valid
  end

  it "it should require a emai" do
    no_user_name = User.new(@valid_attributes.merge(:email => ""))
    no_user_name.should_not be_valid
  end

  it "it should have name shorter than 50 and longer than 3" do
    long_name = "a" * 51
    long_name_user = User.new(@valid_attributes.merge(:name => long_name))
    long_name_user.should_not be_valid

    short_name = "a" * 2
    short_name_user = User.new(@valid_attributes.merge(:name => short_name))
    short_name_user.should_not be_valid
  end

  it "should reject wrong email format" do
    wrong_emails = %w[o2.pl mirek.o2.pl mirek@o2 mirek@o2.pl. mirek@o2,pl,]
    wrong_emails.each do |adress|
      invalid_user = User.new(@valid_attributes.merge(:email => adress))
      invalid_user.should_not be_valid
    end
  end
  
  it "should accept email format" do
    good_emails = %w[mirek@o2.pl MIREK@O2.PL miron_w@o2.pl a_B_B@interia.com]
    good_emails.each do |adress|
      valid_user = User.new(@valid_attributes.merge(:email => adress))
      valid_user.should be_valid
    end
  end

  it "should not allow to have 2 same emails" do
    User.create!(@valid_attributes)
    user_with_duplicated_email = User.new(@valid_attributes)
    user_with_duplicated_email.should_not be_valid
  end

  it "should reject email identical up to case" do
    upper_case = @valid_attributes[:email].upcase
    User.create!(@valid_attributes)
    user_identical_case = User.new(@valid_attributes.merge(:email => upper_case))
    user_identical_case.should_not be_valid
  end
  
end
