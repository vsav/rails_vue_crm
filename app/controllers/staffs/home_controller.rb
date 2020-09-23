class Staffs::HomeController < ApplicationController
  before_action :authenticate_staff!

  def index; end

  def profile
    profile = StaffSerializer.new(current_staff).serializable_hash
    render json: profile[:data][:attributes]
  end
end
