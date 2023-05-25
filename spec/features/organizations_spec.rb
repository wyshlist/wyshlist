require 'rails_helper'

RSpec.feature 'Organizations', type: :feature do
    let(:user) { User.create(email: 'test@gmail.com', password: 'password') }
    let(:organization) { Organization.create(name: 'Test Organization') }
    let(:other_organization) { Organization.create(name: 'Other Organization') }

    before do
        sign_in user
    end

    scenario 'User creates an organization' do
        visit new_organization_path
        fill_in 'Create your team', with: 'Test Organization'
        attach_file '📷 Upload a logo for your team', Rails.root.join('spec/support/assets/images/logo.png')
        click_button 'Submit'

        expect(Organization.last).to have_attributes(
            name: 'Test Organization'
        )
    end

    scenario 'User creates an organization without a logo' do
        visit new_organization_path

        fill_in 'Create your team', with: 'Test Organization No logo'
        click_button 'Submit'

        expect(Organization.last).to have_attributes(
            name: 'Test Organization No Logo'
        )
    end

    scenario 'User cant create exisiting organization'  do
        Organization.create(name: 'Test Organization')
        visit new_organization_path

        fill_in 'Create your team', with: 'Test Organization'
        click_button 'Submit'

        expect(page).to have_content('Name has already been taken')
    end

    scenario 'User finds an organization' do
        Organization.create(name: 'Test Organization')
        visit new_organization_path

        click_button 'Join'
        fill_in 'Search for your team', with: 'Test Organization'
        click_button 'Search'

        expect(page).to have_content('Test Organization')
    end
end