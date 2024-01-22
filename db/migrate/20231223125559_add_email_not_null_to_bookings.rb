# frozen_string_literal: true

class AddEmailNotNullToBookings < ActiveRecord::Migration[7.0]
  def change
    change_column_null :bookings, :email, false
  end
end
