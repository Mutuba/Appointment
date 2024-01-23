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
require 'rails_helper'

RSpec.describe Booking, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :event }
    it { should validate_presence_of :email }

    context 'when required fields are present' do
      it 'is valid' do
        booking = create(:booking)
        expect(booking).to be_valid
        expect do
          create(:booking)
        end.to change { Booking.count }.by(1)
        expect(booking.errors).to be_empty
      end
    end

    context 'when required fields are not present' do
      it 'raises errors' do
        booking = Booking.create(email: nil, event: nil)
        expect(booking).not_to be_valid
        expect(booking.errors.messages[:email]).to include("can't be blank")
        expect(booking.errors.messages[:event]).to include("can't be blank")
      end
    end
  end

  describe 'Associations' do
    it { should belong_to :event }
  end
end
