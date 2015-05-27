FactoryGirl.define do 
    factory :user do |f| 
        f.email 'user@example.com'
        f.username 'user' 
        f.password '123456' 
    end 
end 