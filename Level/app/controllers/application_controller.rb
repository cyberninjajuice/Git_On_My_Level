class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception



  protected
  def not_authenticated
    redirect_to root_path, :alert => "Please sign in first."
  end

  def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
  end

  def correct_user
    @user = current_user
    redirect_to root_url if @user.nil?
  end


  def correct_user?
    if(User.find(params[:id])==current_user)
    end
  end

end
