class Staffs::OrganizationsController < ApplicationController

  before_action :authenticate_staff!

  def index
    organizations = Organization.all
    render json: organizations, each_serializer: OrganizationWithClientsSerializer
  end

  def create
    organization = Organization.new(organization_params)

    if organization.save
      render json: organization, serializer: OrganizationSerializer, status: :created
    else
      render json: { errors: organization.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    organization = Organization.find(params[:id])
    organization.destroy
  end

  def validate_uniqueness
    name = Organization.find_by(name: params[:name])
    inn = Organization.find_by(inn: params[:inn])

    if name && inn
      render json: { uniqueness: { organization_name: "Organization #{params[:name]} already exists",
                                   inn: "Organization with INN: #{params[:inn]} already exists" }}
    elsif name
      render json: { uniqueness: { organization_name: "Organization #{params[:name]} already exists" }}
    elsif inn
      render json: { uniqueness: { inn: "Organization with INN: #{params[:inn]} already exists" }}
    else
      render json: { uniqueness: {} }
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :structure, :inn, :ogrn, :client)
  end
end
