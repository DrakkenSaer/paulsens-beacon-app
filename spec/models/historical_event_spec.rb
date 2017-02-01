require 'spec_helper'

describe HistoricalEvent do
  it "has a valid factory" do
    FactoryGirl.create(:historical_event).should be_valid
  end

  it "is invalid without a title" do
    historical_event = FactoryGirl.build(:historical_event, title: nil).should_not be_valid
  end

  it "is invalid without a description" do
    historical_event = FactoryGirl.build(:historical_event, description: nil).should_not be_valid
  end
  
  it "is invalid without a date" do
    historical_event = FactoryGirl.build(:historical_event, date: nil).should_not be_valid
  end

  it "returns a historical event title as a string" do
    FactoryGirl.create(:historical_event, title: "Bob").title.should == "Bob"
  end
  
  it "returns a historical event description as a string" do
    FactoryGirl.create(:historical_event, description: "Bob").description.should == "Bob"
  end
  
  it "returns a historical event date as a date" do
    FactoryGirl.create(:historical_event, date: "2001-1-1").date.should == "2001-1-1".to_date
  end

end