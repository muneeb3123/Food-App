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
end
