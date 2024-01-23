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
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User Creation with incorrect details' do
    context 'when required fields are missing' do
      it 'raises errors' do
        user = User.create(first_name: 'Daniel', last_name: 'Greenman')
        expect(user).not_to be_valid
        expect(user.errors.messages[:email]).to eq ["can't be blank"]
        expect(user.errors.messages[:password]).to eq ["can't be blank"]
      end
    end

    context 'when email format is invalid' do
      it 'is not valid' do
        user = build(:user, email: 'invalid_email')
        expect(user).not_to be_valid
        expect(user.errors.messages[:email]).to include('is invalid')
      end
    end

    context 'when password length is invalid' do
      it 'is not valid' do
        user = build(:user, password: 'short')
        expect(user).not_to be_valid
        expect(user.errors.messages[:password]).to include('is too short (minimum is 6 characters)')
        user = build(:user, password: 'a' * 129)
        expect(user).not_to be_valid
        expect(user.errors.messages[:password]).to include('is too long (maximum is 128 characters)')
      end
    end

    context 'when email is not unique' do
      it 'raises errors' do
        create(:user, email: 'duplicate@example.com', password: 'random_password')
        user = build(:user, email: 'duplicate@example.com')
        expect(user).not_to be_valid
        expect(user.errors.messages[:email]).to include('has already been taken')
      end
    end
  end

  describe 'User Creation with correct details' do
    context 'when required fields are present' do
      it 'is valid' do
        user = create(:user, email: 'random1234@gmail.com', password: 'random1234')
        expect(user).to be_valid
        expect do
          create(:user, email: 'random12345@gmail.com', password: 'random1234')
        end.to change { User.count }.by(1)
      end
    end
  end
end
