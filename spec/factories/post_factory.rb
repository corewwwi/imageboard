FactoryGirl.define do 
  factory :post do |f| 
    f.created_at 3.day.ago
    f.content 'Post' 
    f.thr_id 1

    factory :post_with_pic do 
      pic { File.new("#{Rails.root}/spec/fixtures/image.jpg") } 

      factory :post_with_pic_and_youtube_video do 
        youtube_video 'https://www.youtube.com/watch?v=F4-kXNzEKAM' 
      end  
        
    end

    factory :post_with_youtube_video do 
      youtube_video 'https://www.youtube.com/watch?v=F4-kXNzEKAM' 
    end

  end 

end

