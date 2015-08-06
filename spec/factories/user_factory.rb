FactoryGirl.define do 
  factory :user do
    email 'user_test@example.com'
    username 'user' 
    password '123456' 
    status 'user'
  
    trait :admin do 
      email 'admin_test@example.com'
      username 'admin' 
      password '123456' 
      status 'admin'
    end 

    trait :banned do 
      email 'banned_test@example.com'
      username 'banned' 
      password '123456' 
      status 'banned'
    end 
    factory :admin, traits: [:admin]
    factory :banned, traits: [:banned]
  end 
end 