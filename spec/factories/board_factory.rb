FactoryGirl.define do 
  factory :board do |f| 
    f.name 'pr'
    f.description 'description' 
    f.terms 'terms' 
    f.bumplimit 5
    f.pages_limit 10
  end 
end 