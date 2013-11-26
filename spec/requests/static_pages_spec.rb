require 'spec_helper'

describe "Static pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_content('Attendance System') }
    it { should_not have_title('| Home') }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        visit root_path
      end

      describe "When I visit menu on homepage" do
        it "should have a the next items" do
          visit root_path
          find_link("Home")
          find_link("Sign in")
        end
      end

    end

  end

end