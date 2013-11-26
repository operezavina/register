require 'spec_helper'

describe Event do

  before do
    @event = Event.new(name: "Example",start_time:"2013-05-05",end_time:"2013-06-06")
  end

  subject { @event }

  it { should respond_to(:name) }
  it { should respond_to(:start_time) }
  it { should respond_to(:end_time) }
  it { should be_valid }

  describe "with admin attribute set to 'true'" do
    before do
      @event.save!
    end

  end

  it "should be valid" do
    expect(@event).to be_valid
  end

  describe "when name is not present" do
    before { @event.name = "" }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @event.name = "a" * 51 }
    it { should_not be_valid }
  end


end