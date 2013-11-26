require 'spec_helper'

describe Category do
  before do
    @category = Category.new(name: "Technologies")
  end

  subject { @category }

  it { should respond_to(:name) }
  it { should be_valid }



    describe "When I visit categories on index" do
      it "should have a the next links" do
        visit "/categories/"
        find_link("New Category")
        click_on('New Category')
      end
    end


  end

