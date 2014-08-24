# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  username             :string(255)
#  first_name           :string(255)
#  last_name            :string(255)
#  surname              :string(255)
#  oblakan_uid          :string(255)
#  role                 :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  email                :string(255)      default(""), not null
#  sign_in_count        :integer          default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  authentication_token :string(255)
#  oblakan_access_token :string(255)
#  avatar               :string(255)
#

require 'spec_helper'

describe User do
  it 'correct processes roles' do
    admin_user = create(:user, :admin)
    staff_user = create(:user, :staff)
    guest_user = create(:user, :guest)
    regular_user = create(:user)

    admin_user.is_admin.should be_true
    staff_user.is_staff.should be_true
    guest_user.is_guest.should be_true
    regular_user.is_regular.should be_true
  end

  it 'properly displays object name' do
    user = create(:user)
    user.to_s.should == user.username
  end
end
