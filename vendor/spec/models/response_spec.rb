require 'spec_helper'

describe Response do

  let(:post) { FactoryGirl.create(:post) }
  before { @response = post.responses.build(content_visitor: "Lorem ipsum",email_visitor:"osvaldo@gmail.com") }

  subject { @response }

  describe "when post_id is not present" do
    before { @response.post_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @response.content_visitor = "" }
    it { should_not be_valid }
  end

  describe "with blank email" do
    before { @response.email_visitor = "" }
    it { should_not be_valid }
  end

end
