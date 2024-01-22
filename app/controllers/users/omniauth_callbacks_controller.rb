# frozen_string_literal: true

# app/controllers/users/omniauth_callbacks_controller.rb

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      user = User.from_omniauth(auth)

      if user.persisted?
        handle_successful_sign_in(user)
      else
        handle_failed_sign_in(auth)
      end
    end

    protected

    def after_sign_in_path_for(resource_or_scope)
      stored_location_for(resource_or_scope) || root_path
    end

    private

    def auth
      @auth ||= request.env['omniauth.auth']
    end

    def handle_successful_sign_in(user)
      sign_out_all_scopes
      flash[:success] = t('devise.omniauth_callbacks.success', kind: 'Google')
      sign_in_and_redirect user, event: :authentication
    end

    def handle_failed_sign_in(auth)
      session['devise.google_data'] = auth.except('extra')
      flash[:alert] =
        t('devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized.")
      redirect_to new_user_session_path
    end
  end
end
