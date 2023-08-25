require 'rails_helper'

describe 'Food Index', type: :feature do
  let!(:user1) do
    User.create(
      name: 'User 1',
      email: 'test@gmail.com',
      password: '123456',
      role: 'admin'
    )
  end

  let!(:food1) do
    Food.create(
      user_id: user1.id,
      name: 'Food 1',
      measurement_unit: 'kg',
      price: 12,
      quantity: 23
    )
  end

  let!(:food2) do
    Food.create(
      user_id: user1.id,
      name: 'Food 2',
      measurement_unit: 'kg',
      price: 12,
      quantity: 23
    )
  end

  before do
    user1.confirm
    visit new_user_session_path
    fill_in 'Email', with: 'test@gmail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
  end

  it 'shuold show the title of the page' do
    visit foods_path
    expect(page).to have_content 'List of foods'
  end

  it 'should show the list of foods' do
    visit foods_path
    expect(page).to have_content 'Food 1'
    expect(page).to have_content 'Food 2'
  end

  it 'should show all attributes of the food' do
    visit foods_path
    expect(page).to have_content 'Food 1'
    expect(page).to have_content 'kg'
    expect(page).to have_content 12
    expect(page).to have_content 23
  end

  it 'I can remove a food' do
    visit foods_path
    first('.row-food .button').click
    expect(page).to_not have_content 'Food 1'
  end

  it 'I can add a food' do
    visit foods_path
    click_link 'Add Food'
    # on the new page
    fill_in 'Name', with: 'Food 3'
    fill_in 'Measurement unit', with: 'kg'
    fill_in 'Price', with: 12
    fill_in 'Quantity', with: 23
    click_button 'Add food'
    # return to the foods page
    expect(page).to have_content 'Food 3'
  end
end
