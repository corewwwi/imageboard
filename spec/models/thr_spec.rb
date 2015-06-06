require 'rails_helper'

RSpec.describe Thr, type: :model do

  context 'validations' do
    let (:valid_thr) { create(:thr) }
    let (:thr_without_title) { build(:thr, title: nil) }
    let (:thr_with_not_valid_title) { build(:thr, title: 'z' * 71) }
    it 'is valid' do
      expect(valid_thr).to be_valid
    end  

    context '.title validations' do
      it { should validate_presence_of(:title) }
      it { should validate_length_of(:title).is_at_most(70) } 
    end 

  end  

  context 'associations' do
    it { should belong_to(:board) }
    it { should belong_to(:user) }
    it { should have_many(:posts).dependent(:destroy) }
    it { should accept_nested_attributes_for :posts }
  end
 
  context '#bump_limit?' do
    let (:thr_without_bumplimit) { create(:thr_without_bumplimit) }
    let (:thr_with_bumplimit) { create(:thr_with_bumplimit) }
    it 'should respond false' do
      expect(thr_without_bumplimit.bump_limit?).to eq false
    end 
    it 'should respond true' do
      expect(thr_with_bumplimit.bump_limit?).to eq true
    end 
  end  

end
