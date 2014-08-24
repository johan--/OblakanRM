# == Schema Information
#
# Table name: subscribers
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  subscribe_type :string(255)
#  subscribe_id   :integer
#  created_at     :datetime
#  updated_at     :datetime
#

require 'spec_helper'

# TODO: Model should be tested without factories

describe Subscriber do
  it 'should react on blacklist' do
    user = create(:user)
    create(:blacklist, user: user)
    subscriber = build(:subscriber, user: user)
    subscriber.should_not be_valid
  end

  it 'should react on guest and regular user with code' do
    guest_user = create(:user, :guest)
    subscriber_guest = build(:subscriber, user: guest_user)
    subscriber_guest.should be_valid
    subscriber_guest.code.present?.should be_true

    user = create(:user)
    subscriber = build(:subscriber, user: user)
    subscriber.should be_valid
  end
end
