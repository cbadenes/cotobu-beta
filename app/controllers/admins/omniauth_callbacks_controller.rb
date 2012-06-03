class Admins::OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def facebook
    # You need to implement the method below in your model
    @admin = Admin.find_for_facebook_oauth(request.env["omniauth.auth"], current_admin)

    if @admin.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in_and_redirect @admin, :event => :authentication
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_admin_registration_url
    end
  end
end