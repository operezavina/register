require 'spec_helper'

describe "Admin dashboard", :type => :feature  do

  subject { page }


  describe "signin_admin_dashboard" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      visit admin_path
      sign_in user
    end
    describe "with valid information as admin" do

      it { should have_link('Profile',     href: user_path(user)) }
      it { should have_link('Settings',    href: edit_user_path(user)) }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
      it { should have_link('End day', href: endday_path) }

    end

    describe "as an admin user" do
      let(:admin) { FactoryGirl.create(:admin) }
      before do
        sign_in admin
        visit users_path
      end

      it { should have_link('delete', href: user_path(User.first)) }
      it "should be able to delete another user" do
        expect do
          click_link('delete', match: :first)
        end.to change(User, :count).by(-1)
      end
      it { should_not have_link('delete', href: user_path(admin)) }
    end

    describe "as admin should have the next options" do
      let(:admin) { FactoryGirl.create(:admin) }
      before do
        sign_in admin
        visit admin_path
      end


      it { should have_content('Admin Dashboard') }
      it { should have_css('.calendar')}    #calendario simple calendar
      it { should have_link('Manage Users')}
      it { should have_link('Admin Dashboard')}
      it { should have_link('Logout')}
      it "should be have links" do
        find_link('Home')
        find_link("Manage User")
        find_link("Manage Events")
        find_link("Manage Project")
        find_link("Profile")
        find_link("Settings")
        find_link("Sign out")
      end
     it {should have_content('Duration by employee')}
     it {should have_content('Duration by project')}

    end

    describe " Manage user for admin" do
      let(:admin) { FactoryGirl.create(:admin) }
      before do
        sign_in admin
        visit admin_path
        click_link("Manage User")
      end

      it { should have_content('All users')}
      it { should have_css('.table')}

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('td', text: user.name)
          expect(page).to have_selector('td', text: user.email)
        end
      end
    end

    describe " Manage projects for admin" do
      let(:admin) { FactoryGirl.create(:admin) }
      let(:project) {FactoryGirl.create(:project)}
      before do
        sign_in admin
        visit admin_path
        click_link("Manage Project")
      end

      it {should have_content('Listing projects')}
      it "should list each project" do
        Project.paginate(page: 1).each do |project|
          expect(page).to have_selector('td', text: project.name)
          expect(page).to have_selector('td', text: project.completed)
          expect(page).to have_link('Destroy', href: projects_path(project))
          expect(page).to have_link('Edit', href: edit_project_path(project))
          expect(page).to have_link('Show', href: show_project_path(project))
        end
      end
      it {should have_link('New Category')}
      it {should have_link('Admin Dashboard')}
    end

    describe "Manage events for admin" do
      let(:admin) { FactoryGirl.create(:admin) }
      before do
        sign_in admin
        visit admin_path
        click_link("Manage Events")
      end

      it {should have_selector('h1',text:'Events')}
      it {should have_selector('label',text:"Search for:")}
      it {should have_css('.table')}
      it "should list each Event" do
        Event.paginate(page: 1).each do |event|
          expect(page).to have_selector('td', text: event.name)
          expect(page).to have_selector('td', text: event.start_time)
          expect(page).to have_selector('td', text: event.end_time)
          expect(page).to have_link('Edit', href: edit_event_path(event))

        end
      end
    end
  end



end