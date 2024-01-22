# frozen_string_literal: true

class AddNotNullToDescriptionToEvents < ActiveRecord::Migration[7.0]
  def change
    change_column_null :events, :name, false
    change_column_null :events, :description, false
  end
end
