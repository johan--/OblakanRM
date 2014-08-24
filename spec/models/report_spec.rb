# == Schema Information
#
# Table name: reports
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  description    :text
#  user_id        :integer
#  status_id      :integer
#  latitude       :float
#  longitude      :float
#  address        :string(255)
#  start_photo_id :integer
#  end_photo_id   :integer
#  is_deleted     :boolean          default(FALSE)
#  created_at     :datetime
#  updated_at     :datetime
#

require 'spec_helper'

describe Report do
  it 'should successfully be created' do
    user = create(:user)
    report = Report.create(title: 'Тест', user: user)

    report.title.should == 'Тест'
  end

  # TODO: DONT WORK, FIX IT.
  it 'should near' do
    user = create(:user)
    report = Report.create(
        title: 'First Report',
        user: user,
        location: 'POINT(91.42991781234741 53.717294976663084)'
    )

    close_report = Report.create(
        title: 'Second Close',
        user: user,
        location: 'POINT(91.42991781234741 53.717294976663084)'
    )

    Report.create(
        title: 'Deleted Close Report',
        user: user,
        location: 'POINT(91.42991781234741 53.717294976663084)',
        is_deleted: true
    )

    Report.create(
        title: 'Far Report',
        user: user,
        location: 'POINT(91.43 54.717)'
    )

    #closest = report.near
    #
    #closest.should include(close_report), "expected #{close_report}, got #{closest.inspect}"
    #closest.count.should == 1
  end
end
