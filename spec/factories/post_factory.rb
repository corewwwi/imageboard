FactoryGirl.define do 
  factory :post do 
    created_at 3.day.ago
    content 'Post' 
    thr_id 1

    trait :with_pic do 
      pic { File.new("#{Rails.root}/spec/fixtures/image.jpg") } 
    end

    trait :with_youtube_video do 
      youtube_video 'https://www.youtube.com/watch?v=F4-kXNzEKAM' 
    end

    factory :post_with_pic,   traits: [:with_pic]   
    factory :post_with_youtube_video, traits: [:with_youtube_video]
    factory :post_with_pic_and_youtube_video, traits: [:with_pic, :with_youtube_video]
  end 

end

