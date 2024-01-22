# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  include Devise::Controllers::Helpers

  before_action :set_time_zone, if: :user_signed_in?, except: [:destroy]

  private

  def set_time_zone
    timezone = determine_timezone
    if timezone.present?
      update_timezone(timezone)
    else
      handle_invalid_timezone
    end
  rescue Geocoder::Error => e
    handle_geocoder_error(e)
  rescue StandardError => e
    handle_unexpected_error(e)
  end

  def determine_timezone
    session[:timezone] = 'UTC' if request.local?
    session[:timezone].presence || fetch_timezone_from_geocoder
  end

  def fetch_timezone_from_geocoder
    result = Geocoder.search(request.ip).first

    if result&.data&.key?('timezone')
      timezone = result.data['timezone']
      session[:timezone] = timezone
      timezone
    else
      handle_invalid_timezone
    end
  end

  def update_timezone(timezone)
    Time.zone = timezone || 'UTC'
    current_user.update!(timezone:)
  end

  def handle_invalid_timezone
    sign_out_and_redirect('Invalid timezone information. Please log in again.')
  end

  def handle_geocoder_error(error)
    sign_out_and_redirect("Geocoder error: #{error.message}")
  end

  def handle_unexpected_error(error)
    sign_out_and_redirect("Unexpected error: #{error.message}")
  end

  def sign_out_and_redirect(message)
    sign_out(current_user)
    flash[:alert] = message
    redirect_to new_user_session_path
  end
end
