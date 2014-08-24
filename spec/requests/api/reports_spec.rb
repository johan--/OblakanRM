require 'spec_helper'

describe 'Reports API' do
  it 'sends list of reports' do
    create_list(:report, 2)

    get api_reports_path
    response.status.should be(200)
    json['reports'].length.should be(2)
  end

  it 'show report correctly' do
    report = create(:report)

    report.comments.each do |comment|
      comment.create_activity :create, owner_id: 1
    end

    get api_reports_path(report)
    response.status.should be(200)
  end
end