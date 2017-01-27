require 'spec_helper'

describe BeaconPolicy do
  subject { Beacon }

  permissions :update?, :create? do
    it "denies access if user is not admin" do
      expect(subject).not_to permit(User.new(email: "steve@steve.com", password: "password"), Beacon.new())
    end
  end
end