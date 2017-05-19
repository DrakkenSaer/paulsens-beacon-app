require 'rails_helper'

RSpec.describe "rewards/show", type: :view do
  before(:each) do
    @reward = assign(:reward, Reward.create!(
      :rewardable => nil,
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
