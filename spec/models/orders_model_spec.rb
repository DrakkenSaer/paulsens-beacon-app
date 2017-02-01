require 'rails_helper'

RSpec.describe Order, :type => :model do
  describe "Associations" do
    it "has many line_items" do
      assc = described_class.reflect_on_association(:line_items)
      expect(assc.macro).to eql :has_many
    end
    
    it "belongs to a user" do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eql :belongs_to
    end
    
    it "has many products" do
      assc = described_class.reflect_on_association(:products)
      expect(assc.macro).to eql :has_many
    end
    
    it "has many promotions" do
      assc = described_class.reflect_on_association(:promotions)
      expect(assc.macro).to eql :has_many
    end
  end
  
end