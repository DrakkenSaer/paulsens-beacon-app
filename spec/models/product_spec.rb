require 'spec_helper'

describe Product do
  it "has a valid factory" do
    FactoryGirl.create(:product).should be_valid
  end

  it "is invalid without a featured, output flase" do
    product = FactoryGirl.create(:product, featured: nil).featured.should == false
  end

  it "is invalid without a cost" do
    product = FactoryGirl.create(:product, cost: nil).cost.should == "0.0"
  end
  
  it "is invalid without a description" do
    product = FactoryGirl.build(:product, description: nil).should_not be_valid
  end
  
  it "is invalid without a title" do
    product = FactoryGirl.build(:product, title: nil).should_not be_valid
  end

  it "returns a product featured as a boolean" do
    FactoryGirl.create(:product, featured: true).featured.should == true
  end
  
  it "returns a product description as a string" do
    FactoryGirl.create(:product, description: "Bob").description.should == "Bob"
  end
  
  it "returns a product title as a string" do
    FactoryGirl.create(:product, title: "Bob").title.should == "Bob"
  end
  
  it "returns a product cost as a string" do
    FactoryGirl.create(:product, cost: "10.99").cost.should == "10.99"
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
end