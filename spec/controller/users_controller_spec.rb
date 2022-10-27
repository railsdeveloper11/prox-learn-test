require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user_params) do
    {
      "email": Faker::Internet.email,
      "first_name": Faker::Name.first_name,
      "last_name": Faker::Name.last_name,
      "nickname": Faker::Name.suffix,
      "phone": Faker::PhoneNumber.phone_number
    }
  end

  describe "GET /index" do
    it "returns http success" do
      get :index
      
      expect(response.status).to eq(200)
    end
  end

  describe "POST /users" do
    scenario "valid user attributes" do
      post :create, params: {
        "user": user_params
      }
      expect(response.status).to eq(200)
      # check the value of the returned response hash
      expect(response).to have_http_status(:ok)
      expect(response.media_type).to eq Mime[:turbo_stream]
      expect(response.body).to include('<turbo-stream action="append" target="users">')
      expect(response.body).to include('<turbo-stream action="replace" target="modal">')

      # 1 new user record is created
      expect(User.count).to eq(1)

      # Optionally, you can check the latest record data
      expect(User.last.email).to eq(user_params.dig(:email))
    end

    scenario "invalid user attributes" do
      post :create, params: {
        "user": {
          "email":"",
          "first_name":"",
          "last_name":"",
          "nickname": Faker::Name.suffix,
          "phone": Faker::PhoneNumber.phone_number
        }
      }
      expect(response.status).to eq(422)
    end
  end
end
