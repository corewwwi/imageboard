require 'rails_helper'

RSpec.describe Board, type: :model do

  context 'validations' do

    it "is valid" do
      expect(FactoryGirl.build(:board)).to be_valid
    end   

    context '.name validations' do

      it "is not valid without .name" do
        expect(FactoryGirl.build(:board, name: nil)).not_to be_valid
      end

      it "is not valid with duplicate .name" do
        FactoryGirl.create(:board)
        board = FactoryGirl.build(:board, name: 'pr')
        board.valid?
        expect(board.errors[:name]).to include("has already been taken")
      end  

      it "is not valid with .name less then 5 characters" do
        expect(FactoryGirl.build(:board, name: '123456')).not_to be_valid
      end 

    end 

    context '.pages_limit validations' do

      it "is not valid with not numeric :pages_limit" do
        expect(FactoryGirl.build(:board, pages_limit: 'foobar')).not_to be_valid
      end

      it "is not valid with not integer .pages_limit" do
        expect(FactoryGirl.build(:board, pages_limit: 5.6)).not_to be_valid
      end

      it "is not valid with .pages_limit less then 0" do
        expect(FactoryGirl.build(:board, pages_limit: -1)).not_to be_valid
      end

    end  

    context '.bumplimit validations' do

      it "is not valid with not numeric .bumplimit" do
        expect(FactoryGirl.build(:board, bumplimit: 'foobar')).not_to be_valid
      end

      it "is not valid with not integer .bumplimit" do
        expect(FactoryGirl.build(:board, bumplimit: 5.6)).not_to be_valid
      end

      it "is not valid with .bumplimit less then 0" do
        expect(FactoryGirl.build(:board, bumplimit: -1)).not_to be_valid
      end
      
    end 

    context ':description validations' do

      it "is not valid with .description greater then 30 characters" do
        string = 'z' * 31
        expect(FactoryGirl.build(:board, description: string)).not_to be_valid
      end
      
    end 

    context '.terms validations' do

      it "is not valid with .terms greater then 100 characters" do
        string = 'z' * 101
        expect(FactoryGirl.build(:board, terms: string)).not_to be_valid
      end
      
    end 

  end

  context 'associations' do
    it { should have_many(:thrs).dependent(:destroy) }
  end

end