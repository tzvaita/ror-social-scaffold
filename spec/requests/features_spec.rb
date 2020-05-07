require 'rails_helper'

RSpec.feature 'Integrations', type: :feature do
  before :each do
    user = User.create!(name: 'Foo', email: 'foobar@example.org', password: 'foobar', password_confirmation: 'foobar')
    user_2 = User.create!(name: 'Bar', email: 'bar@example.org', password: '123456', password_confirmation: '123456')
    user_3 = User.create!(name: 'Jam', email: 'jam@example.org', password: '123456', password_confirmation: '123456')
    friendship = Friendship.create!(user_id: user_2.id, friend_id: user.id, confirmed: false)

    visit new_user_session_path
    expect(page.current_path).to eq '/users/sign_in'
    page.fill_in 'Email', with: 'foobar@example.org'
    page.fill_in 'Password', with: 'foobar'
    click_button 'Log in'
    expect(page.current_path).to eq '/'
    click_on 'All users'
    expect(page.current_path).to eq '/users'
  end

  scenario 'Create a Friend Request' do
    have_button 'Invite to friends'
    click_on 'Invite to friends'
    expect(page).to have_text 'Friendship request sent successfully'
    have_button 'Cancel Request Sent'
  end

  scenario 'Accept a Friend Request' do
    have_button 'Accept Request'
    have_button 'Cancel Request'
    click_on 'Accept Request'
    expect(page).to have_text 'Friendship request accepted'
    have_button 'Remove'
    have_button 'Go to Friend\'s Profile'
  end

  scenario 'Reject a Friend Request' do
    have_button 'Accept Request'
    have_button 'Cancel Request'
    click_on 'Cancel Request'
    expect(page).to have_text 'Friendship request canceled'
    have_button 'Add Friend'
  end
end
