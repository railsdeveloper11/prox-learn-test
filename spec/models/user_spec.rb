require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe 'validations' do 
    specify 'validate presence of email, first_name, last_name, phone' do
      expect(user).to validate_presence_of(:email).on(:create)
      expect(user).to validate_presence_of(:first_name).on(:create)
      expect(user).to validate_presence_of(:last_name).on(:create)
      expect(user).to validate_presence_of(:phone).on(:create)
    end

    it { should validate_uniqueness_of(:email).case_insensitive }
  end
end
