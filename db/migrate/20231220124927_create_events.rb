# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name
      t.string :color
      t.integer :duration
      t.boolean :customer_paid
      t.boolean :payment_required
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
