FactoryGirl.define do 
  factory :user do
    email 'user@example.com'
    username 'user' 
    password '123456' 
    status 'user'
  
    trait :admin do 
      email 'admin@example.com'
      username 'admin' 
      password '123456' 
      status 'admin'
    end 

    trait :banned do 
      email 'banned@example.com'
      username 'banned' 
      password '123456' 
      status 'banned'
    end 
    factory :admin, traits: [:admin]
    factory :banned, traits: [:banned]
  end 
end 