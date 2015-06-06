require 'rails_helper'

RSpec.describe Board, type: :model do

  context 'validations' do
    let (:valid_board) { build(:board) }
    it "has valid factory" do
      expect(valid_board).to be_valid
    end   

    context '.name validations' do
      it { should validate_presence_of(:name) }
      it { should validate_uniqueness_of(:name) }
      it { should validate_length_of(:name).is_at_most(5) }
    end 

    context '.pages_limit validations' do
      it { should validate_numericality_of(:pages_limit).only_integer.is_greater_than(0) }
    end  

    context '.bumplimit validations' do
      it { should validate_numericality_of(:bumplimit).only_integer.is_greater_than(0) }
    end 

    context ':description validations' do
      it { should validate_length_of(:description).is_at_most(30) }
    end 

    context '.terms validations' do
      it { should validate_length_of(:terms).is_at_most(100) }
    end 
    
  end

  context 'associations' do
    it { should have_many(:thrs).dependent(:destroy) }
  end

end