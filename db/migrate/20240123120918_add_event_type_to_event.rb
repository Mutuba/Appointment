# frozen_string_literal: true

class AddEventTypeToEvent < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :event_type, :integer, default: 0
  end
end
