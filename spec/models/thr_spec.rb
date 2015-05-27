require 'rails_helper'

RSpec.describe Thr, type: :model do

  context 'validations' do

    it 'is valid' do
      expect(FactoryGirl.create(:thr)).to be_valid
    end  

    context '.title validations' do

      it 'is not valid without .title' do
        expect(FactoryGirl.build(:thr, title: nil)).not_to be_valid
      end  

      it 'is not valid with .title greater then 70 characters' do
        string = 'z' * 71
        expect(FactoryGirl.build(:thr, title: string)).not_to be_valid
      end  

    end 

  end  

  context 'associations' do

    it { should belong_to(:board) }
    it { should belong_to(:user) }
    it { should have_many(:posts).dependent(:destroy) }

  end
 
  context '#bump_limit?' do

    it 'should respond false' do
      thr = FactoryGirl.build(:thr_without_bumplimit)
      expect(thr.bump_limit?).to be_falsey
    end 

    it 'should respond true' do
      thr = FactoryGirl.create(:thr_with_bumplimit)
      expect(thr.bump_limit?).to be_truthy
    end 

  end  

end
