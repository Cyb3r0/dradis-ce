require 'rails_helper'

describe 'User notifications', type: :feature do
  before do
    login_to_project_as_user
    visit root_path
  end

  it 'can view the notifcation bell' do
    within '.navbar' do
      expect(page).to have_css '.notifications.dropdown'
    end
  end

  pending 'notifications list with ajax', js: true do
    context 'the user has no notifications' do
      it 'shows an empty dropdown' do
        find('.js-notifications-dropdown').click
        expect(find('.no-content', text: 'You have no notifications yet.')).to_not be_nil
      end
    end

    context 'the user has some notifications' do
      it 'shows the notification list' do
        issue = create(:issue, text: 'Test issue')
        create(:notification, notifiable: issue, actor: @logged_in_as, recipient: @logged_in_as)

        visit root_path
        find('.js-notifications-dropdown').click
        expect(page).to have_content "#{@logged_in_as.email} commented"
      end
    end
  end
end