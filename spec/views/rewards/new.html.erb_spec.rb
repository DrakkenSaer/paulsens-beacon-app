require 'rails_helper'

RSpec.describe "rewards/new", type: :view do
  before(:each) do
    assign(:reward, Reward.new(
      :rewardable => nil,
      :user => nil
    ))
  end

  it "renders new reward form" do
    render

    assert_select "form[action=?][method=?]", rewards_path, "post" do

      assert_select "input#reward_rewardable_id[name=?]", "reward[rewardable_id]"

      assert_select "input#reward_user_id[name=?]", "reward[user_id]"
    end
  end
end
