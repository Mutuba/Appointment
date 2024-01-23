# frozen_string_literal: true

# spec/requests/users/sessions_controller_spec.rb

require 'rails_helper'

RSpec.describe 'Users::SessionsController', type: :request do
  before(:each) do
    # Mock authentication
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      provider: 'google_oauth2',
      uid: '123456',
      info: { email: 'fakegmail@gmail.com' }
    )

    # Simulate a user signing in
    post '/users/auth/google_oauth2/callback'
  end

  describe 'DELETE /users/sign_out' do
    it 'signs out the user and redirects to the sign-in path' do
      delete '/users/sign_out'

      expect(response).to redirect_to(new_user_session_path)
      expect(session[:user_timezone]).to be_nil
      expect(flash[:notice]).to be_present
      expect(flash[:notice][:type]).to eq('success')
      expect(flash[:notice][:message]).to eq('Successfully signed out.')
    end
  end
end
