class Staffs::HomeController < ApplicationController
  before_action :authenticate_staff!
  skip_before_action :verify_authenticity_token, only: [:create_client, :delete_client]

  def index; end

  def profile
    render json: current_staff, serializer: StaffSerializer
  end

  def clients_list
    clients = Client.all
    render json: clients, each_serializer: ClientSerializer
  end

  def create_client
    client = Client.new(client_params)

    if client.save
      render json: client, serializer: ClientSerializer, status: :created
    else
      render json: { errors: client.errors }, status: :unprocessable_entity
    end
  end

  def delete_client
    client = Client.find(params[:id])
    client.destroy
  end

  private

  def client_params
    params.require(:client).permit(:email,
                                   :full_name,
                                   :phone,
                                   :password,
                                   :password_confirmation)
  end
end
