require 'rails_helper'

RSpec.describe Employment, type: :model do
  subject(:employment) { build(:employment) }

  describe 'validations' do
    specify 'validate presence of user, employer, start_date, end_date' do
      expect(employment).to validate_presence_of(:employer).on(:create)
      expect(employment).to validate_presence_of(:start_date).on(:create)
      expect(employment).to validate_presence_of(:end_date).on(:create)
    end
  end
end
