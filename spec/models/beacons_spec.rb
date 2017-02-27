require 'rails_helper'

RSpec.describe Beacon, type: :model do
  subject { FactoryGirl.build(:beacon) }
    
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
    
    it "assigns default uuids when saved" do
        subject.save
        expect(subject.uuid).to_not be_nil
        expect(subject.major_uuid).to_not be_nil
        expect(subject.minor_uuid).to_not be_nil
        expect(subject.uuid.length).to eql SecureRandom.uuid.length
        expect(subject.major_uuid.length).to eql SecureRandom.uuid.length
        expect(subject.minor_uuid.length).to eql SecureRandom.uuid.length
    end
  end
    
  
  describe "Uniqueness Validations" do
    before(:each) do
      subject.save
      @test_beacon = FactoryGirl.build(:beacon)
    end
  
    it "is not valid if the title is not unique" do
        expect(@test_beacon).to_not be_valid
    end
    
    it "is not valid if UUID is not unique" do
        @test_beacon.uuid = subject.uuid
        expect(@test_beacon).to_not be_valid
    end
    
    it "is not valid if major_uuid is not unique" do
        @test_beacon.major_uuid = subject.major_uuid
        expect(@test_beacon).to_not be_valid
    end
    
    it "is not valid if minor UUID is not unique" do
      @test_beacon.minor_uuid = subject.minor_uuid
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