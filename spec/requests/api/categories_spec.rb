require 'spec_helper'

describe 'Categories' do
  it 'sends list of categories' do
    create_list(:category, 2)

    get api_categories_path
    response.status.should be(200)
    json['categories'].length.should be(2)
  end

  it 'show category correctly' do
    category = create(:category)

    get api_categories_path(category)
    response.status.should be(200)
  end
end
