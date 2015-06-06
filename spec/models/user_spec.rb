require 'rails_helper'

RSpec.describe User, type: :model do

  context 'validations' do
    let(:user) { build(:user) }

    it "is valid" do
      expect(user).to be_valid 
    end

    context ".email validations" do
      it { should validate_presence_of(:email) }
      it { should validate_uniqueness_of(:email) }
    end  

    context ".username validations" do
      it { should validate_presence_of(:username) }
      it { should validate_uniqueness_of(:username) }
    end  

    context ".password validations" do
      it { should validate_presence_of(:password) }
      it { should validate_length_of(:password).is_at_least(6).is_at_most(128) }
    end  
    
  end

  context 'associations' do
    it { should have_many(:thrs) }
    it { should have_many(:posts) }
    it { should define_enum_for(:status) }
  end  

end
