require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:food) { Food.new }

  it 'name should be present' do
    food.name = nil
    expect(food).not_to be_valid
  end

  it 'measurement_unit should be present' do
    food.measurement_unit = nil
    expect(food).not_to be_valid
  end

  it 'price should be present' do
    food.price = nil
    expect(food).not_to be_valid
  end

  it 'price should be greater than 0' do
    food.price = 0
    expect(food).not_to be_valid

    food.price = -1
    expect(food).not_to be_valid
  end

  it 'quantity should be present' do
    food.quantity = nil
    expect(food).not_to be_valid
  end

  it 'quantity should be greater than 0' do
    food.quantity = 0
    expect(food).not_to be_valid

    food.quantity = -1
    expect(food).not_to be_valid
  end  
end
