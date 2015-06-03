module ApplicationHelper
  def current_user
    #first check basically whether log_in function has happened...
    if (user_id= session[:user_id])
      # CURRENT USER = user.find_by Id or whatever it
      # was which is probably the one in the params. blue||green
      #maintain former state or change to this state called User.find_by...
      @current_user ||= User.find_by(id: user_id)
      #encrypted version of =signed...
    elsif (user_id= cookies.signed[:user_id])
      #Sets user to the same thing as above =or 
      user = User.find_by(id: user_id)
      #only allow the user to become that user if they're authenticated.
      if user && user.authenticated?(cookies[:remember_token])
        #if we pass all the authentication tests we log in user and set current user
        #to be that user.
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end
end
