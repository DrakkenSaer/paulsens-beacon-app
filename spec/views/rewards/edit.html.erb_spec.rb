require 'rails_helper'

RSpec.describe "rewards/edit", type: :view do
  before(:each) do
    @reward = assign(:reward, Reward.create!(
      :rewardable => nil,
      :user => nil
    ))
  end

  it "renders the edit reward form" do
    render

    assert_select "form[action=?][method=?]", reward_path(@reward), "post" do

      assert_select "input#reward_rewardable_id[name=?]", "reward[rewardable_id]"

      assert_select "input#reward_user_id[name=?]", "reward[user_id]"
    end
  end
end
