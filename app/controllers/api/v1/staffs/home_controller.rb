class Api::V1::Staffs::HomeController < ApplicationController

  before_action :authenticate_staff!

  def show
    render json: current_staff.to_json
  end
end

