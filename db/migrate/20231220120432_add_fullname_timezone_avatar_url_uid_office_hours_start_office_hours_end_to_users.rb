# frozen_string_literal: true

class AddFullnameTimezoneAvatarUrlUidOfficeHoursStartOfficeHoursEndToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :office_hours_start, :time
    add_column :users, :office_hours_end, :time
    add_column :users, :fullname, :string
    add_column :users, :timezone, :string
    add_column :users, :avatar_url, :string
    add_column :users, :uid, :string
  end
end
