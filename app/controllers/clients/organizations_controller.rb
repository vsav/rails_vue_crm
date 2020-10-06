class Clients::OrganizationsController < ApplicationController

  before_action :authenticate_client!

  def index
    organizations = current_client.organizations
    render json: organizations
  end
end
