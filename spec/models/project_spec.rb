require 'spec_helper'

describe Project do

  before do
    @project = Project.new(name: "Example",completed:false)
  end

  subject { @project }

  it { should respond_to(:name) }
  it { should respond_to(:completed) }
  it { should be_valid }

  describe "with admin attribute set to 'true'" do
    before do
      @project.save!
    end

  end

  it "should be valid" do
    expect(@project).to be_valid
  end

  describe "when name is not present" do
    before { @project.name = "" }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @project.name = "a" * 51 }
    it { should_not be_valid }
  end


end
