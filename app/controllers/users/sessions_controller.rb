# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    def after_sign_out_path_for(_resource_or_scope)
      new_user_session_path
    end

    def destroy
      session[:timezone] = nil if session[:timezone].present?
      super
      flash[:notice] = { type: 'success', message: 'Successfully signed out.' }
    end
  end
end
