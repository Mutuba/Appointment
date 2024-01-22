# frozen_string_literal: true

# == Schema Information
#
# Table name: bookings
#
#  id            :bigint           not null, primary key
#  customer_paid :boolean
#  email         :string           not null
#  ends_at       :datetime
#  first_name    :string
#  last_name     :string
#  starts_at     :datetime
#  status        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  event_id      :bigint           not null
#
# Indexes
#
#  index_bookings_on_event_id  (event_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#
class Booking < ApplicationRecord
  enum status: { accepted: 0, rejected: 1 }
  belongs_to :event

  validates :event, presence: true

  validates :email, presence: true
end
