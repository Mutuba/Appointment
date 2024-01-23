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
#  event_type       :integer          default("interview")
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
FactoryBot.define do
  factory :event do
    name { 'Random meeting' }
    description { 'Awesome description' }
    color { 'Random #fff' }
    duration { 30 }
    event_type { 0 }
    start_at { Time.now }
    end_at { Time.now }
    customer_paid { false }
    payment_required { false }
    association :user, factory: :user
  end
end
