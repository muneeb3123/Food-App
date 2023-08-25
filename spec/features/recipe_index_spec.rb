require 'rails_helper'

describe 'Recipe Index', type: :feature do
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

  let!(:recipe2) do
    Recipe.create(
      user_id: user1.id,
      name: 'Recipe 2',
      preparation_time: 12,
      cooking_time: 23,
      description: 'Recipe 2 directions',
      public: false
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
    visit recipes_path
    expect(page).to have_content 'All Recipes'
  end

  it 'I can see the public recipe' do
    visit recipes_path
    expect(page).to have_content 'Recipe 1'
    expect(page).to have_content 'Recipe 1 directions'
  end

  it 'I can see the private recipe' do
    visit recipes_path
    expect(page).to have_content 'Recipe 2'
    expect(page).to have_content 'Recipe 2 directions'
  end

  it 'I can create a new recipe' do
    visit recipes_path
    click_link 'create new'
    # on the new page
    fill_in 'Name', with: 'Recipe 3'
    fill_in 'Preparation time', with: 12
    fill_in 'Cooking time', with: 23
    fill_in 'Description', with: 'Recipe 3 directions'
    click_button 'Add Recipe'
    # return to the recipes page
    expect(page).to have_content 'Recipe 3'
    expect(page).to have_content 'Recipe 3 directions'
  end

  it 'I can click on the recipe name to see the recipe details' do
    visit recipes_path
    click_link 'Recipe 1'
    expect(page).to have_content 'Recipe 1'
    expect(page).to have_content 'Preparation time: 12'
    expect(page).to have_content 'Cooking time: 23'
    expect(page).to have_content 'Recipe 1 directions'

    expect(page).to_not have_content 'Recipe 2'
    expect(page).to have_content 'Add ingredient'
  end
end
