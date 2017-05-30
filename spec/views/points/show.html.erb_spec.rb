require 'rails_helper'

RSpec.describe "credits/show", type: :view do
  before(:each) do
    @credit = assign(:credit, Credit.create!(
      :value => "Value"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Value/)
  end
end
