class Staffs::ClientsController < ApplicationController
  def index
    clients = Client.all
    render json: clients, each_serializer: ClientSerializer
  end

  def create
    client = Client.new(client_params)

    if client.save
      render json: client, serializer: ClientSerializer, status: :created
    else
      render json: { errors: client.errors }, status: :unprocessable_entity
    end
  end

  def destroy
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
