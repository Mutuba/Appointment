# frozen_string_literal: true

# == Schema Information
#
# Table name: events
#
#  id               :bigint           not null, primary key
#  color            :string
#  customer_paid    :boolean
#  description      :string           not null
#  duration         :integer
#  end_at           :datetime         not null
#  name             :string           not null
#  payment_required :boolean
#  start_at         :datetime         not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_events_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Event < ApplicationRecord
  belongs_to :user

  validates :user, presence: true

  validates :name, :description, :start_at, :end_at, presence: true
end
