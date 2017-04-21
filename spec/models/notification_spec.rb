require 'rails_helper'

RSpec.describe Notification, :type => :model do

  before :each do
    @beacon = FactoryGirl.create(:beacon, title: "#{rand(1..1000000)}", major_uuid: "#{rand(1..10000000)}", minor_uuid: "#{rand(1..100000)}")
    @notification = @beacon.notifications.create(FactoryGirl.attributes_for(:notification))
  end

  describe "Presence Validations" do
    it "is valid with valid attributes" do
      expect(@notification).to be_valid
    end

    it "is not valid without a title" do
      @notification.title = nil
      expect(@notification).to_not be_valid
    end

    it "is not valid without a description" do
      @notification.description = nil
      expect(@notification).to_not be_valid
    end

    it "is valid without an entry message" do
      @notification.entry_message = nil
      expect(@notification).to be_valid
    end

    it "is not valid without an exit message" do
      @notification.description = nil
      expect(@notification).to_not be_valid
    end
  end

  describe "Uniqueness Validations" do
    before :each do
      @test_notification = @beacon.notifications.build(FactoryGirl.attributes_for(:notification, title: nil, description: nil))
    end

    it "is not valid if the title and description are not unique" do
      expect(@test_notification).to_not be_valid
    end

    it "is valid if the title and description are both unique" do
      @test_notification.title = "Unique Title"
      @test_notification.description = "Unique Description"
      expect(@test_notification).to be_valid
    end
  end

  describe "Associations" do
    it "belongs to a beacon" do
      assc = Notification.reflect_on_association(:notifiable)
      expect(assc.macro).to eql :belongs_to
    end
  end
end