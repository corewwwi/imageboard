require "rails_helper"

RSpec.describe "boards/index" do
  it "displays all the boards" do
    assign(:boards, [
      create(:board, name: 'mu'),
      create(:board, name: 'mov')
    ])
    render
    expect(rendered).to match /mu/
    expect(rendered).to match /mov/
  end
end