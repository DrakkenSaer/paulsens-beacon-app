require 'rails_helper'

describe HistoricalEvent do
  it "has a valid factory" do
    expect( FactoryGirl.create(:historical_event) ).to be_valid
  end

  it "is invalid without a title" do
    expect( FactoryGirl.build(:historical_event, title: nil) ).not_to be_valid
  end

  it "is invalid without a description" do
    expect( FactoryGirl.build(:historical_event, description: nil) ).not_to be_valid
  end
  
  it "is invalid without a date" do
    expect( FactoryGirl.build(:historical_event, date: nil) ).not_to be_valid
  end

  it "returns a historical event title as a string" do
    expect( FactoryGirl.create(:historical_event, title: "Bob").title ).to eq( "Bob" )
  end
  
  it "returns a historical event description as a string" do
    expect( FactoryGirl.create(:historical_event, description: "Bob").description ).to eq( "Bob" )
  end
  
  it "returns a historical event date as a date" do
    expect( FactoryGirl.create(:historical_event, date: "2001-1-1").date ).to eq( "2001-1-1".to_date )
  end
  
  it "will not save the same data in the model" do
    FactoryGirl.create(:historical_event)
    expect( FactoryGirl.build(:historical_event) ).not_to be_valid
  end 

end