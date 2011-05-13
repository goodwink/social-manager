require 'spec_helper'

describe "campaigns/index.html.haml" do
  before(:each) do
    assign(:campaigns, [
      stub_model(Campaign),
      stub_model(Campaign)
    ])
  end

  it "renders a list of campaigns" do
    render
  end
end
