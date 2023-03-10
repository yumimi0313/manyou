FactoryBot.define do
  factory :user do
    name { "test_user_01" }
    email { "test01@aaa.com" }
    password { "password" }
    admin { true }
  end

  factory :second_user, class: User do
    name { "test_user_02" }
    email { "test_user_02@dic.com" }
    password { "password" }
    admin { false }
  end

  factory :third_user, class: User do
    name { "test_user_03" }
    email { "test_user_03@dic.com" }
    password { "password" }
    admin { false }
  end
end
