class Staffs::OrganizationsController < ApplicationController

  before_action :authenticate_staff!

  def index
    organizations = Organization.all
    render json: organizations, each_serializer: StaffOrganizationsSerializer
  end
end
