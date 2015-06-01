FactoryGirl.define do 

  factory :thr do |f| 
    f.id 1
    f.user_id 1
    f.title 'Thread'
    association :board, factory: :board

       
    factory :thr_without_bumplimit do  
      
      ignore do
        posts_count 4
      end
      after(:create) do |thr, evaluator|
        create_list(:post, evaluator.posts_count, thr: thr)
       end
    end 

    factory :thr_with_bumplimit do  
      
      ignore do
        posts_count 5
      end
      after(:create) do |thr, evaluator|
        create_list(:post, evaluator.posts_count, thr: thr)
       end
    end

  end
end
