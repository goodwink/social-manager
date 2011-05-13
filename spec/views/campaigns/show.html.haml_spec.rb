require 'spec_helper'

describe "campaigns/show.html.haml" do
  before(:each) do
    @campaign = assign(:campaign, stub_model(Campaign))
  end

  it "renders attributes in <p>" do
    render
  end
end
