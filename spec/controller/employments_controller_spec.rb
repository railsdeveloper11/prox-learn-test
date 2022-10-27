require 'rails_helper'

RSpec.describe EmploymentsController, type: :controller do
  let!(:user) { create(:user) }

  let(:employment_params) do
    {
      "employer": Faker::Name.name,
      "start_date": Faker::Date.in_date_period,
      "end_date": Faker::Date.forward(days: 23),
      "user_id": user.id
    }
  end

  describe "POST /employments" do
    scenario "valid employment attributes" do
      post :create, params: {
        "employment": employment_params
      }
      expect(response.status).to eq(200)
      # check the value of the returned response hash
      expect(response).to have_http_status(:ok)
      expect(response.media_type).to eq Mime[:turbo_stream]
      expect(response.body).to include('<turbo-stream action="prepend" target="flash">')

      # 1 new user record is created
      expect(Employment.count).to eq(1)

      # Optionally, you can check the latest record data
      expect(Employment.last.employer).to eq(employment_params.dig(:employer))
    end

    scenario "invalid employment attributes" do
      post :create, params: {
        "employment":  {
          "employer": "",
          "start_date": Faker::Date.in_date_period,
          "end_date": Faker::Date.forward(days: 23),
          "user_id": user.id
        }
      }
      expect(response.status).to eq(422)
    end
  end
end
