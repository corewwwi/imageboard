FactoryGirl.define do 

  factory :thr do
    id 1
    user_id 1
    title 'Thread'
    board
    
    trait :without_bumplimit do  
      ignore do
        posts_count 4
      end
      after(:create) do |thr, evaluator|
        create_list(:post, evaluator.posts_count, thr: thr)
       end
    end 

    trait :with_bumplimit do  
      ignore do
        posts_count 5
      end
      after(:create) do |thr, evaluator|
        create_list(:post, evaluator.posts_count, thr: thr)
       end
    end
    factory :thr_without_bumplimit, traits: [:without_bumplimit] 
    factory :thr_with_bumplimit, traits: [:with_bumplimit]  
  end

end
