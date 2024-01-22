# frozen_string_literal: true

class RenameColumnFullnameToFullNameOnUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :fullname, :full_name
  end
end
