require 'rails_helper'

RSpec.describe Post, type: :model do

  context 'validations' do

    it 'is valid' do
      expect(FactoryGirl.create(:post)).to be_valid
    end

    context '.content validation' do

      it 'is not valid without .content' do
        expect(FactoryGirl.build(:post, content: nil)).not_to be_valid
      end

      it 'is not valid with .content greater than 15000 characters' do
        string = 'z' * 15001
        expect(FactoryGirl.build(:post, content: string)).not_to be_valid
      end

    end  

    context '.youtube_video validation' do

      it 'is valid with youtube format string .youtube_video' do
        valid_youtube_link = 'https://www.youtube.com/watch?v=F4-kXNzEKAM'
        expect(FactoryGirl.build(:post, youtube_video: valid_youtube_link)).to be_valid
      end

      it 'is not valid with not youtube format string .youtube_video' do
        not_valid_youtube_link = 'https://www.github.com'
        expect(FactoryGirl.build(:post, youtube_video: not_valid_youtube_link)).not_to be_valid
      end

    end

    context '.pic validation' do

    end  

    context 'validate #only_one_media' do

      it 'is valid with only .pic' do
        expect(FactoryGirl.build(:post_with_pic)).to be_valid
      end  

      it 'is valid with only .youtube_video' do
        expect(FactoryGirl.build(:post_with_youtube_video)).to be_valid
      end 

      it 'is not valid with .pic and .youtube_video' do
        post_with_both_media = FactoryGirl.build(:post_with_pic_and_youtube_video)
        post_with_both_media.valid?
        expect(post_with_both_media.errors[:youtube_video]).to include 'cannot be added with Image'
      end

    end  

  end 

  context 'associations' do
    it { should belong_to(:thr) }
    it { should belong_to(:user) }
    it { should have_and_belong_to_many (:answers) }
    it { should have_and_belong_to_many (:parent_posts) }
  end 

  context '#post_with_answers' do

    context 'without answers'do

      it 'should not have .answers' do
        expect(FactoryGirl.build(:post).answers.count).to eq(0)
      end
      
      it 'should not have .parent_posts' do
        expect(FactoryGirl.build(:post).parent_posts.count).to eq(0)
      end

    end  

    context 'with answers' do

      let!(:parent_post) { FactoryGirl.create(:post) }
      let!(:answer) { FactoryGirl.create(:post, content: ">>#{parent_post.id}") }
         
      it 'should have .answers' do
        expect(parent_post.answers.count).to eq(1)
        expect(parent_post.answers.last).to eq(answer)
      end
      
      it 'should have .parent_posts' do
        expect(answer.parent_posts.count).to eq(1)
        expect(answer.parent_posts.last).to eq(parent_post)
      end  

    end   

  end 

  context '#youtube_embed' do

    it 'should return embed string' do
      post = FactoryGirl.build(:post_with_youtube_video)
      embed_string = %Q{ <iframe class="embed-responsive-item" frameborder="0" width="560" height="315" src="//www.youtube.com/embed/F4-kXNzEKAM" allowfullscreen=""></iframe> }
      expect(post.youtube_embed).to eq(embed_string)
    end  

  end 

  context '#post_number' do
    let!(:thr) { FactoryGirl.create(:thr) }
    let!(:first_post) { FactoryGirl.create(:post, created_at: 5.day.ago) }
    let!(:second_post) { FactoryGirl.create(:post, created_at: 4.day.ago) }
    let!(:third_post) { FactoryGirl.create(:post, created_at: 3.day.ago) }

    it 'should return post number' do
      expect(first_post.post_number).to eq(1)
      expect(second_post.post_number).to eq(2)
      expect(third_post.post_number).to eq(3)
    end  
     
  end 

end
