class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new
    @user["first_name"] = params["first_name"]
    @user["last_name"] = params["last_name"]
    @user["email"] = params["email"]
    @user["password"] = params["password"]
    
    if @user["email"] == "" || @user["password"] == ""
      flash["notice"] = "Email or Password cannot be blank!"
      redirect_to "/users/new"
    else
      if User.find_by({"email" => @user["email"]}) == nil
        # TODO: encrypt user's password "at rest"  
        @user["password"] = BCrypt::Password.create(params["password"])
        @user.save
        redirect_to "/posts"
      else   
        flash["notice"] = "An account with this email already exists! Please try a different email or login to your account."
        redirect_to "/users/new"
      end
    end  
      
  end

end
