class OauthsController < ApplicationController
  skip_before_filter :require_login
  before_filter :require_login, only: :destroy

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if @user = login_from(provider)
      flash[:success]= "Logged in using #{provider.titleize}!"
      authorization_code = auth_params[:code]
      puts current_user
      puts authorization_code
      redirect_to root_path
    else
      if logged_in?
        link_account(provider)
        redirect_to root_path
      else
        flash[:alert] = "You must login through GitHub to access this feature!"
        redirect_to login_path
      end
    end
  end

  def destroy
    provider= params[:provider]

    authentication = current_user.authentications.find_by_provider(provider)
    if authentication.present?
      authentication.destroy
      flash[:notice] = "Your #{provider.titleize} account removed."
    else
      flash[:alert] = "Your #{provider.titleize} account was not found."
    end
    redirect_to root_path
  end

  private
  def link_account(provider)
    if @user = add_provider_to_user(provider)
      flash[:success] = "Great work! Your #{provider.titleize} is linked and you are now ready to Levl UP!"
    else
      flash[:alert] = "There was a problem linking your #{provider.titleize} account." 
    end
  end

  def auth_params
    params.permit(:code, :provider)
  end
end
