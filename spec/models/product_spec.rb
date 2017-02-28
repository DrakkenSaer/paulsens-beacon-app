require 'rails_helper'

RSpec.describe Product, type: :model do
    subject { FactoryGirl.build(:product) }

    describe "Associations" do
      it "have many promotions" do
        assc = described_class.reflect_on_association(:promotions)
        expect(assc.macro).to eq :has_many
      end
    end

    describe "Validations" do
      it "is valid with valid attributes" do 
          expect(subject).to be_valid
      end

      it "is not valid without a description" do
          subject.description = nil
          expect(subject).to_not be_valid
      end

      it "is not valid without a title" do
          subject.title = nil
          expect(subject).to_not be_valid
      end
    end

    describe "Callbacks" do
      it "adds a default cost of 0.0 if one is not specified" do
        subject.cost = nil
        subject.save
        expect( subject.cost ).to eq("0.0")
      end
    end
    
    describe "Return types" do
      it "returns a product featured as a boolean" do
        subject.featured = true
        subject.save
        expect( subject.featured ).to eq(true)
      end
      
      it "returns a product description as a string" do
        subject.description = "Bob"
        subject.save
        expect( subject.description ).to eq("Bob")
      end
      
      it "returns a product title as a string" do
        subject.title = "Bob"
        subject.save
        expect( subject.title ).to eq("Bob")
      end
      
      it "returns a product cost as a string" do
        subject.cost = "10.99"
        subject.save
        expect( subject.cost ).to eq("10.99")
      end
    end

    describe "Resource Methods" do
      context "purchase!" do
        before(:each) do
          @user = FactoryGirl.create(:user)
        end
        
        it "takes in a user as an argument" do
          expect { subject.purchase! }.to raise_error(ArgumentError)
        end
        
        it "adds a line_item to the order" do
         subject.save
         expect { subject.purchase!(@user) }.to change { @user.line_items.count }.by(1)
        end
          
        it "line_item is also associated with an order" do
          subject.save
          subject.purchase!(@user)
          expect(@user.line_items.last.order).to_not be_nil
        end
        
        it "the order is associated to the passed in user" do
          subject.save
          subject.purchase!(@user)
          expect(@user.line_items.last.find_resource).to eql subject
        end
    end
  end
end