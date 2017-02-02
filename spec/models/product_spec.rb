require 'rails_helper'

describe Product do
  subject {FactoryGirl.build(:product) }
  
  it "has a valid factory" do
    expect( FactoryGirl.create(:product) ).to be_valid
  end

  it "is invalid without a featured, output flase" do
    expect( FactoryGirl.create(:product, featured: nil).featured ).to eq(false)
  end

  it "is valid without a cost" do
    expect( FactoryGirl.create(:product, cost: nil).cost ).to eq("0.0")
  end
  
  it "is valid without a description" do
    expect( FactoryGirl.build(:product, description: nil) ).not_to be_valid
  end
  
  it "is invalid without a title" do
    expect( FactoryGirl.build(:product, title: nil) ).not_to be_valid
  end

  it "returns a product featured as a boolean" do
    expect( FactoryGirl.create(:product, featured: true).featured ).to eq(true)
  end
  
  it "returns a product description as a string" do
    expect( FactoryGirl.create(:product, description: "Bob").description ).to eq("Bob")
  end
  
  it "returns a product title as a string" do
    expect( FactoryGirl.create(:product, title: "Bob").title ).to eq("Bob")
  end
  
  it "returns a product cost as a string" do
    expect( FactoryGirl.create(:product, cost: "10.99").cost ).to eq("10.99")
  end

  it "have many promotions" do
    assc = described_class.reflect_on_association(:promotions)
    expect(assc.macro).to eq :has_many
  end
  
  it "have many line_items" do
    assc = described_class.reflect_on_association(:line_items)
    expect(assc.macro).to eq :has_many
  end
  
  it "have many orders" do
    assc = described_class.reflect_on_association(:orders)
    expect(assc.macro).to eq :has_many
  end
  
  describe "#purchase!" do
    before(:each) do
      @user = FactoryGirl.create(:user)
    end
    
    it "takes in a user as an argument" do
      expect { subject.purchase! }.to raise_error(ArgumentError)
    end
    
    it "adds a line_item to the product" do
     subject.save
     expect { subject.purchase!(@user) }.to change { subject.line_items.count }.by(1)
    end
      
    it "line_item is also associated with an order" do
      subject.save
      subject.purchase!(@user)
      expect(subject.line_items.last.order).to_not be_nil
    end
    
    it "the order is associated to the passed in user" do
      subject.save
      subject.purchase!(@user)
      expect(subject.line_items.last.order.user).to eql @user
    end
    
  end
end