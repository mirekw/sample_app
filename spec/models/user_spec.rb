require 'spec_helper'

describe User do
  before(:each) do
    @valid_attributes = {
      :name => "Mirek",
      :email => "miron_w@o2.pl",
      :password => "mireczek",
      :password_confirmation => "mireczek"
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
  
  describe "password validation" do

    before(:each) do
      @user = User.create!(@valid_attributes)
    end

    it "should require a password and confirmation" do
      User.new(@valid_attributes.merge(:password => "",:password_confirmation => "" )).
        should_not be_valid
    end

    it "should have same password connfirmation" do
      User.new(@valid_attributes.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end

    it "should have minimal pasword lenght" do
      short_pass = "a" * 5
      User.new(@valid_attributes.merge(:password => short_pass)).
        should_not be_valid
    end
    
    it "should have max pasword lenght" do
      too_long_pass = "a" * 41
      User.new(@valid_attributes.merge(:password => too_long_pass)).
        should_not be_valid
    end
  end

  describe "password encription" do

    before(:each) do
      @user = User.create!(@valid_attributes)
    end

    it "should respond to encrypted password" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end
  
    describe "has password? method" do
      it "should be true if the password match" do
        @user.has_password?(@valid_attributes[:password]).should be_true
      end
    
      it "should be false if the password don't match" do
        @user.has_password?("invalid").should be_false
      end
      describe "authenticate method"

      it "should retun nil if email and password not match" do
        wrong_password_user = User.authenticate(@valid_attributes[:email],"wrongpass")
        wrong_password_user.should be_nil
      end

      it "should return nill if the user doesn't exist" do
        no_user_password = User.authenticate("wrong@domain.com","wrongpass")
        no_user_password.should be_nil
      end

      it "should return user if authentication in ok" do
        match_user = User.authenticate(@valid_attributes[:email],@valid_attributes[:password])
        match_user.should == @user
      end
    end
  end

  describe "remember me" do
    before(:each) do
      @user = User.create!(@valid_attributes)
    end

    it "should have a remember_me! method" do
      @user.should respond_to(:remember_me!)
    end

    it "should have the remember token" do
      @user.should respond_to(:remember_token)
    end

    it "should set the remember token" do
      @user.remember_me!
      @user.remember_token.should_not be_nil
    end
    
  end

end
