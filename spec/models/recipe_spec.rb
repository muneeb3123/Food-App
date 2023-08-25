require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:recipe) { Recipe.new }

  it 'name should be present' do
    recipe.name = nil
    expect(recipe).not_to be_valid
  end

  it 'preparation time should be present' do
    recipe.preparation_time = nil
    expect(recipe).not_to be_valid
  end

  it 'preparation time should be greater than 0' do
    recipe.preparation_time = 0
    expect(recipe).not_to be_valid

    recipe.preparation_time = -1
    expect(recipe).not_to be_valid
  end

  it 'cooking time should be present' do
    recipe.cooking_time = nil
    expect(recipe).not_to be_valid
  end

  it 'cooking time should be greater than 0' do
    recipe.cooking_time = 0
    expect(recipe).not_to be_valid

    recipe.cooking_time = -1
    expect(recipe).not_to be_valid
  end

  it 'description should be present' do
    recipe.description = nil
    expect(recipe).not_to be_valid
  end
end
