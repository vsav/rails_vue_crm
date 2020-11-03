class Staffs::HomeController < ApplicationController
  before_action :authenticate_staff!

  def index; end

  def profile
    render json: current_staff, serializer: StaffSerializer
  end

  def update_password
    @staff = current_staff
    if @staff.update(staff_params)
      bypass_sign_in(@staff)
      render json: @staff, serializer: StaffSerializer, status: :ok
    else
      render json: { errors: @staff.errors }, status: :unprocessable_entity
    end
  end

  private

  def staff_params
    params.require(:staff).permit(:password, :password_confirmation)
  end
end
