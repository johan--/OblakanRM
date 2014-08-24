require 'spec_helper'

describe 'Subscribers API' do
  describe 'POST /tasks' do
    it 'create subscriber' do
      2.times do
        post api_subscribers_path, subscriber: build(:subscriber).attributes
      end

      get api_subscribers_path
      response.status.should be(200)
      json['subscribers'].length.should be(2)
    end

    context 'when logged in' do
      before (:each) do
        @user = create(:user)
        login_as(@user, :scope => :user)
      end

      it 'delete subscriber' do
        subscriber = create(:subscriber, user: @user)

        delete api_subscriber_path(subscriber)
        response.status.should be(204)
      end

      it 'try to delete wrong subscriber' do
        subscriber = create(:subscriber)

        delete api_subscriber_path(subscriber)
        response.status.should be(422)
      end
    end

    context 'when logged out' do
      let(:user_guest) { create(:user, :guest) }

      it 'delete subscriber' do
        subscriber = create(:subscriber, user: user_guest)

        delete api_subscriber_path(subscriber), code: subscriber.code
        response.status.should be(204)
      end

      it 'try to delete subscriber with empty params' do
        subscriber = create(:subscriber, user: user_guest)

        delete api_subscriber_path(subscriber)
        response.status.should be(422)
      end

      it 'try to delete subscriber with wrong params' do
        subscriber = create(:subscriber, user: user_guest)

        delete api_subscriber_path(subscriber), code: '1'
        response.status.should be(422)
      end
    end
  end

  it 'show' do
    subscriber = create(:subscriber)

    get api_subscribers_path(subscriber)
    response.status.should be(200)
  end
end