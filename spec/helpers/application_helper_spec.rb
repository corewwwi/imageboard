require "rails_helper"

RSpec.describe ApplicationHelper, :type => :helper do

  describe "#pretty_datetime" do
    it "return pretty datetime format" do
      datetime = Time.new(2015, 5, 31, 2, 38, 38)  
      expect(helper.pretty_datetime(datetime)).to eq("31 May 2015 02:38:38")
    end
  end

  describe "#error_messages_for" do
    let! (:post) { build(:post) }

    it "renders the error_messages partial" do
      expect(helper.error_messages_for(post)).to render_template(partial: 'application/_error_messages', locals: { object: post })
    end
  end

end