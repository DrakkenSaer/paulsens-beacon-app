require 'rails_helper'

describe LineItem do
  it "has a valid factory" do
    expect( FactoryGirl.create(:line_item) ).to be_valid
  end

  it "belongs to promotions" do
    assc = described_class.reflect_on_association(:order)
    expect(assc.macro).to eq :belongs_to
  end
  
  it "belongs to orderable as a polymorphic record" do
    assc = described_class.reflect_on_association(:orderable)
    expect(assc.macro).to eq :belongs_to
  end
  
end