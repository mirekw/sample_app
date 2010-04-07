# == Schema Information
# Schema version: 20100403232823
#
# Table name: users
#
#  id                 :integer(4)      not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation

  
  EmailRegex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  validates_presence_of :name, :email
  validates_length_of :name, :within => 3..50
  validates_format_of :email, :with => EmailRegex
  validates_uniqueness_of :email, :case_sensitive => false

  #Password validation
  validates_presence_of :password, :password_confirmation
  validates_confirmation_of :password
  validates_length_of :password, :within => 6..40, :too_short => "Password is too short",
    :too_long => "Password is too long"

  before_save :encrypt_password

  def has_password?(submited_password)
    encrypted_password == encrypt(submited_password)
  end

  def remember_me!
    self.remember_token = encrypt("#{salt}--#{id}")
    save_without_validation
  end

  def self.authenticate(email, submited_password)
    user = find_by_email(email)
    user && user.has_password?(submited_password) ? user : nil
  end
  
  # private

  def encrypt_password
    unless password.nil?
      self.salt = make_salt
      self.encrypted_password = encrypt(password)
    end
  end

  def encrypt(string)
    secure_hash("#{salt}#{string}")
  end

  def make_salt
    secure_hash("#{Time.now.utc}#{password}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end

end
