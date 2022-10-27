class EmploymentsController < ApplicationController
  before_action :find_user, only: :create

  # POST /employments or /employments.json

  def new
    @employment = Employment.new
  end

  def create
    @employment = Employment.new(employment_params)
    if @employment.save
      @user.update(employment_id: @employment)
      flash.now[:notice] = "Employment was successfully created." 
      render turbo_stream: turbo_stream.replace("flash", partial: "layouts/flash")
    else
      render turbo_stream: turbo_stream.replace(
        'modal',
        partial: 'employments/form',
        locals: {
          user: @user,
          employment: @employment
        }
      ), status: :unprocessable_entity
    end
  end

  private
    def find_user
      @user = User.find(params.dig(:employment, :user_id))
    end

    # Only allow a list of trusted parameters through.
    def employment_params
      params.require(:employment).permit(:employer, :start_date, :end_date)
    end
end
