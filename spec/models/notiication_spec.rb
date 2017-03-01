require 'rails_helper'

RSpec.describe Notification, :type => :model do
  subject {FactoryGirl.build(:notification)}
  
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
    
    it "is not valid without an entry message" do
      subject.entry_message = nil
      expect(subject).to_not be_valid
    end
    
    it "is not valid without an exit message" do
      subject.description = nil
      expect(subject).to_not be_valid
    end
  end
  
  describe "Uniqueness Validations" do
    before(:each) do
      subject.save
      @test_notification = FactoryGirl.build(:notification, beacon_id: nil)
    end
    
    it "is not valid if the title is not unique" do
      expect(@test_notification).to_not be_valid
    end
    
    it "is not valid if the title is not unique" do
      @test_notification.title = "Unique Title"
      expect(@test_notification).to_not be_valid
    end
  end
  
  describe "Associations" do
    it "belongs to a beacon" do
      assc = described_class.reflect_on_association(:beacon)
      expect(assc.macro).to eql :belongs_to
    end
  end
end