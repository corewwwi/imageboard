require 'rails_helper'

RSpec.describe Post, type: :model do

  context 'validations' do
    let (:valid_post) { build(:post) }
    it 'is valid' do
      expect(valid_post).to be_valid
    end
    context '.content validation' do
      it { should validate_presence_of(:content) }
      it { should validate_length_of(:content).is_at_most(15000) }
    end  

    context '.youtube_video validation' do
      it { should allow_value("https://www.youtube.com/watch?v=F4-kXNzEKAM").for(:youtube_video) }
      it { should_not allow_value("https://www.github.com").for(:youtube_video) }
      it { should_not allow_value("drhrsthsht").for(:youtube_video) }
    end

    context '.pic validation' do
    end  

    context 'validate #only_one_media' do
      let (:post_with_pic) { build(:post_with_pic) }
      let (:post_with_youtube_video) { build(:post_with_youtube_video) }
      let (:post_with_pic_and_youtube_video) { build(:post_with_pic_and_youtube_video) }
      it 'is valid with only .pic' do
        expect(post_with_pic).to be_valid
      end  
      it 'is valid with only .youtube_video' do
        expect(post_with_youtube_video).to be_valid
      end 
      it 'is not valid with .pic and .youtube_video' do
        post_with_pic_and_youtube_video.valid?
        expect(post_with_pic_and_youtube_video.errors[:youtube_video]).to include 'cannot be added with Image'
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
    let!(:parent_post) { create(:post) }
    let!(:answer) { create(:post, content: ">>#{parent_post.id}") }
    it 'should have answers' do
      expect(parent_post.answers.count).to eq(1)
      expect(parent_post.answers.last).to eq(answer)
    end
    it 'should have parent_posts' do
      expect(answer.parent_posts.count).to eq(1)
      expect(answer.parent_posts.last).to eq(parent_post)
    end  
  end 

  context '#youtube_embed' do
    let(:post_with_youtube_video) { build(:post_with_youtube_video) }
    it 'should return embed string' do
      embed_string = %Q{ <iframe class="embed-responsive-item" frameborder="0" width="560" height="315" src="//www.youtube.com/embed/F4-kXNzEKAM" allowfullscreen=""></iframe> }
      expect(post_with_youtube_video.youtube_embed).to eq(embed_string)
    end  
  end 

  context '#post_number' do
    let(:thr) { create(:thr) }
    let(:first_post) { create(:post, created_at: 5.day.ago, thr: thr) }
    let(:second_post) { create(:post, created_at: 4.day.ago, thr: thr) }
    let(:third_post) { create(:post, created_at: 3.day.ago, thr: thr) }
    it 'should return post number' do
      expect(first_post.post_number).to eq(1)
      expect(second_post.post_number).to eq(2)
      expect(third_post.post_number).to eq(3)
    end  
  end 

end
