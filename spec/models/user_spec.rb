require 'rails_helper'

RSpec.describe User, type: :model do

  context 'validations' do

    it "is valid" do
      expect(FactoryGirl.build(:user)).to be_valid 
    end

    it "is invalid without .email" do
      expect(FactoryGirl.build(:user, email: nil)).not_to be_valid 
    end

    it "is invalid without .username" do
      expect(FactoryGirl.build(:user, username: nil)).not_to be_valid 
    end

    it "is invalid without .password" do
      expect(FactoryGirl.build(:user, password: nil)).not_to be_valid 
    end

    it "is invalid with a duplicate .email" do
      FactoryGirl.create(:user)
      user = FactoryGirl.build(:user, email: 'user@example.com')
      user.valid?
      expect(user.errors[:email]).to include("has already been taken")
    end

    it "is invalid with a duplicate .username" do
      FactoryGirl.create(:user)
      user = FactoryGirl.build(:user, username: 'user')
      user.valid?
      expect(user.errors[:username]).to include("has already been taken")
    end

    it "is invalid with a duplicate case sensitive .username" do
      FactoryGirl.create(:user)
      user = FactoryGirl.build(:user, username: 'UsEr')
      user.valid?
      expect(user.errors[:username]).to include("has already been taken")
    end

    it "is invalid with .password less then 6 characters" do
      expect(FactoryGirl.build(:user, password: '12345')).not_to be_valid 
    end
    
  end

  context 'associations' do
    it { should have_many(:thrs) }
    it { should have_many(:posts) }
    it { should define_enum_for(:status) }
  end  

end
