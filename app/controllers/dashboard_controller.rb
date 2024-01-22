# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
end
