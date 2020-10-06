class Staffs::OrganizationsController < ApplicationController

  before_action :authenticate_staff!

  def index
    organizations = Organization.all
    render json: organizations
  end
end
