class Staffs::HomeController < ApplicationController
  before_action :authenticate_staff!

  def index; end

  def profile
    render json: current_staff, serializer: StaffSerializer
  end
end
