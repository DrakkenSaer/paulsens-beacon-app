require 'rails_helper'

RSpec.describe "Show Pages Route", :type => :request do
  
  describe "allowed parameter strings" do
    before :each do
       sign_in(FactoryGirl.create(:admin))
       5.times { |i| FactoryGirl.create(:beacon, title: "new #{i}", description: "description #{i}") }
    end
    
    it "assigns veriable if parameter string is only model name" do
      get root_path(resources: {beacons: "Beacon"})
      expect(assigns(:beacons).count).to eql Beacon.count
    end
    
    it "allows use of limit" do
      get root_path(resources: {beacons: "Beacon.limit(2)"})
      expect(assigns(:beacons).count).to eql 2
      expect(assigns(:beacons).count).to_not eql Beacon.count
    end
    
    it "allows use of order" do
      get root_path(resources: {beacons: "Beacon.order(id: :desc)"})
      expect(assigns(:beacons).count).to eql Beacon.count
      expect(assigns(:beacons).first).to eql Beacon.last
    end
    
    it "allows use of where" do
      get root_path(resources: {beacons: "Beacon.where(title: 'new 4')"})
      expect(assigns(:beacons).count).to eql 1
      expect(assigns(:beacons)).to include Beacon.last
    end
    
    it "allows supported queries to be chained" do
      get root_path(resources: {beacons: "Beacon.order(id: :desc).limit(2)"})
      expect(assigns(:beacons).count).to eql 2
      expect(assigns(:beacons).first).to eql Beacon.last
    end
  end
  
  describe "invalid parameter strings are not evaluated/assigned" do
    it "does not respond to parameters not structures as queries" do
      get root_path(resources: {beacons: "give me all beacons pls"})
      expect(assigns(:beacons)).to be_nil
    end
    
    it "does not respond to unsupported queries" do
      orig_count = Beacon.count
      get root_path(resources: {beacons: "Beacon.create(title: 'test', description: 'test', address: '1 test st', city: 'test town', state: 'test', postal: 'test', country: 'us', start_date: DateTime.now, estimated_completion_date: DateTime.now)"})
      expect(assigns(:beacons)).to be_nil
      expect(Beacon.count).to eql orig_count
    end
    
    it "does not evaluate at all if unsupported queries are chained to supported queries" do
      get root_path(resources: {beacons: "Beacon.order(id: :desc).take(2)"})
      expect(assigns(:beacons)).to be_nil
    end
  end
end