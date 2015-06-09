module ApplicationHelper
  def current_user
    #first check basically whether log_in function has happened...
    if (user_id= session[:user_id])
      # CURRENT USER = user.find_by Id or whatever it
      @current_user ||= User.find_by(id: user_id)
      #encrypted version of =signed...
    elsif (user_id= cookies.signed[:user_id])
      #Sets user to the same thing as above =or 
      user = User.find_by(id: user_id)
      #only allow the user to become that user if they're authenticated.
      if user && user.authenticated?(cookies[:remember_token])
        #if we pass all the authentication tests we l
        log_in user
        @current_user = user
      end
    end
  end

  def full_title(page_title= "")
    base_title = "Git on My Levl!"
    if page_title.empty?
      base_title
    else
      "#{page_title}| #{base_title}"
    end
  end

  def gravatar_for(user, options= {size: 80})
    gravatar_id = Digest::MD5::hexdigest(user.email)
    size=options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: "gravatar")
  end

  def logged_in?
    !current_user.nil?
  end
end
