require 'rails_helper'

RSpec.describe User, type: :model do
  # create a subjet user
  subject { User.new(name: 'Test User', email: 'test@mail.com', role: 'admin') }

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).not_to be_valid
  end

  it 'email should be present' do
    subject.email = nil
    expect(subject).not_to be_valid
  end

  it 'role should be present' do
    subject.role = nil
    expect(subject).not_to be_valid
  end
end
