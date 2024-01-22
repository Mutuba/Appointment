# frozen_string_literal: true

class AddStartAtEndAtToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :start_at, :datetime, null: false
    add_column :events, :end_at, :datetime, null: false
  end
end
