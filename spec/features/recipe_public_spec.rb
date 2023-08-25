require 'rails_helper'

describe 'Recipe Public', type: :feature do
  let!(:user1) do
    User.create(
      name: 'User 1',
      email: 'test@gmail.com',
      password: '123456',
      role: 'admin'
    )
  end

  let!(:recipe1) do
    Recipe.create(
      user_id: user1.id,
      name: 'Recipe 1',
      preparation_time: 12,
      cooking_time: 23,
      description: 'Recipe 1 directions',
      public: true
    )
  end

  before do
    user1.confirm
    visit new_user_session_path
    fill_in 'Email', with: 'test@gmail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
  end

  it 'shows the food public page' do
    visit root_path
    expect(page).to have_content 'Public Recipes'
  end

  it 'I can see the public recipe' do
    visit root_path
    expect(page).to have_content 'Recipe 1'
    expect(page).to have_content 'Recipe 1 directions'
  end
end
