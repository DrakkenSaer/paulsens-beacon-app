require 'rails_helper'

RSpec.describe "rewards/index", type: :view do
  before(:each) do
    assign(:rewards, [
      Reward.create!(
        :rewardable => nil,
        :user => nil
      ),
      Reward.create!(
        :rewardable => nil,
        :user => nil
      )
    ])
  end

  it "renders a list of rewards" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
