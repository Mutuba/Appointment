# frozen_string_literal: true

# == Schema Information
#
# Table name: time_slots
#
#  id         :bigint           not null, primary key
#  end_at     :datetime
#  start_at   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :bigint           not null
#
# Indexes
#
#  index_time_slots_on_event_id  (event_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#
FactoryBot.define do
  factory :time_slot do
    start_at { '2023-12-20 16:07:24' }
    end_at { '2023-12-20 16:07:24' }
    association :event, factory: :event
  end
end
