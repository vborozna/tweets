# frozen_string_literal: true
module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def twitter
      @user = User.from_omniauth(request.env['omniauth.auth'])

      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: 'Twitter') if is_navigational_format?
      else
        session['devise.twitter_data'] = request.env['omniauth.auth']
        redirect_to new_user_registration_url
      end
    end
  end

  def after_omniauth_failure_path_for(scope)
    new_user_session(scope)
  end
end
