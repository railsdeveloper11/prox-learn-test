class UsersController < ApplicationController
  before_action :set_user, only: :employer_details

  # GET /users or /users.json
  def index
    @users = User.includes(:employment)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  def employer_details
    @employment = @user.employment
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      render turbo_stream: [
        turbo_stream.append(
          'users',
          partial: 'user',
          locals: {
            user: @user,
          }
        ),
        turbo_stream.replace(
          'modal',
          partial: 'employments/form',
          locals: {
            user: @user,
            employment: Employment.new
          }
        ),
        turbo_stream.remove("no_records_found")
      ]
    else
      render turbo_stream: turbo_stream.replace(
        'errors',
        partial: 'users/errors',
        locals: {
          user: @user
        }
      ), status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:first_name, :last_name,:nick_name, :email, :phone)
    end
end
