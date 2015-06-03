class SessionsController < ApplicationController
def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      flash[:notice] = "Login through GitHub Successful!"
      redirect_to root_path
    else
      flash[:alert] = "There was an error with your GitHub login :("
      render :new
    end
  end

  def destroy
    logout
    flash[:notice] = "Logout Successful!"
    redirect_to root_path
  end
end

end
