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
class Event < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validate :validate_start_and_end_time

  validates :name, :description, :start_at, :end_at, :event_type, presence: true

  enum event_type: {
    interview: 0,
    consultation: 1,
    follow_up_call: 2
  }

  def validate_start_and_end_time
    office_hours_range = user.office_hours_start_in_timezone.strftime('%H:%M')..
    user.office_hours_end_in_timezone.strftime('%H:%M')

    time_range = Time.parse(office_hours_range.begin)..Time.parse(office_hours_range.end)

    errors.add(:start_at, "must be within office hours") unless time_range.cover?(Time.parse(start_at))
    errors.add(:end_at, "must be within office hours") unless time_range.cover?(Time.parse(start_at))

  end
end
