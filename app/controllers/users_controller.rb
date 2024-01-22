# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def edit; end

  def update
    @user = current_user
    respond_to do |format|
      if @user.update(office_hours_params)
        format.html { redirect_to root_path, notice: 'Office hours was successfully set.' }
        format.json { render :show, status: :ok, location: @user }
        format.html { redirect_to root_path }

      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  private

  def office_hours_params
    params.require(:user).permit(:office_hours_start, :office_hours_end)
  end
end
