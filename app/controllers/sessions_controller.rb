class SessionsController < ApplicationController
  def new
  end
  
  def create
    # TODO: authenticate user
    # Ensure that email and password is not blank
    if params["email"] != "" && params["password"] != ""
      # If not, first, try to find user using their unique identifier, i.e. email
      @user = User.find_by({"email" => params["email"]})
      if @user != nil
        # if user exists, check if they know their password
        if BCrypt::Password.new(@user["password"]) == params["password"]
          # add a secure cookie for this user
          session["user_id"] = @user["id"]  
          # display welcome message
          flash["notice"] = "Welcome #{@user["first_name"]}"
          redirect_to "/posts"
        else
          flash["notice"] = "Sorry, wrong password!"
          redirect_to "/login"
        end  
      else
        flash["notice"] = "This email does not exist."
        redirect_to "/login"    
      end
    else
      flash["notice"] = "Email or password cannot be blank."
      redirect_to "/login"
    end      
  end

  def destroy
    # logout the user
      session["user_id"] = nil
      flash["notice"] = "Goodbye!"
      redirect_to "/login"
  end

end
