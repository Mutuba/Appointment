# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  avatar_url             :string
#  email                  :string           not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  full_name              :string
#  last_name              :string
#  office_hours_end       :time
#  office_hours_start     :time
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  timezone               :string
#  uid                    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :user do
    first_name { 'Daniel' }
    last_name { 'Greenman' }
    email { Faker::Internet.unique.email }
    password { 'password' }
  end
end
