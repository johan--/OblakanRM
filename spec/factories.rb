FactoryGirl.define do
  sequence(:random_string) {|n| SecureRandom.urlsafe_base64(nil, false) }

  factory :user do
    username { Faker::Internet.user_name }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    oblakan_uid { generate(:random_string) }

    trait :admin do
      role 'admin'
    end

    trait :guest do
      oblakan_uid ''
    end

    trait :staff do
      role 'staff'
    end
  end

  factory :subscriber do
    user
  end

  factory :blacklist do
    user
  end

  factory :report do
    user
    category
    title 'Тестовая проблема'
    description 'Описание проблемы'
    location 'POINT (91.43 53.717)'
  end

  factory :category do
    title 'Тестовая категория'
    description 'Описание категории'
  end
end