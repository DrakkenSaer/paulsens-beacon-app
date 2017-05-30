require 'rails_helper'

RSpec.describe "credits/edit", type: :view do
  before(:each) do
    @credit = assign(:credit, Credit.create!(
      :value => "MyString"
    ))
  end

  it "renders the edit credit form" do
    render

    assert_select "form[action=?][method=?]", credit_path(@credit), "post" do

      assert_select "input#credit_value[name=?]", "credit[value]"
    end
  end
end
