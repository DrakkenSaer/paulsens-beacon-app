require 'rails_helper'

RSpec.describe "credits/index", type: :view do
  before(:each) do
    assign(:credits, [
      Credit.create!(
        :value => "Value"
      ),
      Credit.create!(
        :value => "Value"
      )
    ])
  end

  it "renders a list of credits" do
    render
    assert_select "tr>td", :text => "Value".to_s, :count => 2
  end
end
