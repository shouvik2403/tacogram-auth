class ApplicationController < ActionController::Base
  before_action :current_user

  def current_user
    puts "------------------ code before every request ------------------"
    # Optional: @current_user = ...
    @current_user = session["user_id"]
  end
end
