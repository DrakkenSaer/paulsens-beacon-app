require 'rails_helper'

RSpec.describe Promotion, type: :model do
  subject { FactoryGirl.build(:promotion) }
  
  describe "Presence Validations" do
    it "is valid with valid attributes" do 
        expect(subject).to be_valid
    end
    
    it "is not valid without a title" do
        subject.title = nil
        expect(subject).to_not be_valid
    end
    
    it "is not valid without a description" do
        subject.description = nil
        expect(subject).to_not be_valid
    end
    
    it "is not valid without a code" do
        subject.code = nil
        expect(subject).to_not be_valid
    end
    
    it "assigns a default expiration date if it becomes nil" do
      subject.expiration = nil
      subject.save
      expect(subject.expiration).to_not be_nil
    end
  end
    
  describe "Assigning default values" do
    it "assigns a default cost if it becomes nil" do
      subject.cost = nil
      subject.save
      expect(subject.cost).to_not be_nil
      expect(subject.cost).to eql(0)
    end
    
    it "assigns a default redeem_count if it becomes nil" do
      subject.redeem_count = nil
      subject.save
      expect(subject.redeem_count).to_not be_nil
      expect(subject.redeem_count).to eql 0
    end
    
    it "assigns featured false if it becomes nil" do
      subject.featured = nil
      subject.save
      expect(subject.featured).to eql false
    end
    
    it "assigns expiration false if it becomes nil" do
      subject.featured = nil
      subject.save
      expect(subject.featured).to eql false
    end
  end
  
  describe "Associations" do
    it "has many line_items" do
      assc = described_class.reflect_on_association(:line_items)
      expect(assc.macro).to eql :has_many
    end
    
    it "has many orders" do
      assc = described_class.reflect_on_association(:orders)
      expect(assc.macro).to eql :has_many
    end
    
    it "belongs to promotional" do
      assc = described_class.reflect_on_association(:promotional)
      expect(assc.macro).to eql :belongs_to
    end
  end
end