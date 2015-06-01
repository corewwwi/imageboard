FactoryGirl.define do 
  factory :user do |f| 
    f.email 'user@example.com'
    f.username 'user' 
    f.password '123456' 
    f.status 'user'
  
    factory :admin do |f| 
      f.email 'admin@example.com'
      f.username 'admin' 
      f.password '123456' 
      f.status 'admin'
    end 

    factory :banned do |f| 
      f.email 'banned@example.com'
      f.username 'banned' 
      f.password '123456' 
      f.status 'banned'
    end 
  end 
end 