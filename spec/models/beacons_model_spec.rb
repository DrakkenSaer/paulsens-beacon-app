require 'rails_helper'

RSpec.describe Beacon, :type => :model do
  subject {FactoryGirl.build(:beacon) }
    
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
    
    it "assigns a default uuid when saved" do
        subject.save
        expect(subject.uuid).to_not be_nil
        expect(subject.uuid.length).to eql SecureRandom.uuid.length
    end
  end
    
  
  describe "Uniqueness Validations" do
    before(:each) do
      @test_beacon = FactoryGirl.build(:beacon)
    end
  
    it "is not valid if the title is not unique" do
        subject.save
        expect(@test_beacon).to_not be_valid
    end
    
    it "is not valid if UUID is not unique" do
        subject.save
        @test_beacon.uuid = subject.uuid
        expect(@test_beacon).to_not be_valid
    end
  end
  
  describe "Associations" do
    it "has many notifications" do
      assc = described_class.reflect_on_association(:notifications)
      expect(assc.macro).to eql :has_many
    end
  end
end