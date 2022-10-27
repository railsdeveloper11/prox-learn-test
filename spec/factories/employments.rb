
FactoryBot.define do
  factory :employment do
    employer {Faker::Company.name}
    start_date {Faker::Date.in_date_period}
    end_date {Faker::Date.in_date_period}

    after(:create) do |employment|
      user = create(:user)
      user.employment_id = employment.id
      user.save
    end
  end
end
