class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def new
    @user = User.new
    @title = "Sign up"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to @user
      flash[:success] = "Welcome to my world"
    else
      @title = "Sign up"
      @user.password = nil
      @user.password_confirmation = nil
      render 'new'    
    end
  end
end
