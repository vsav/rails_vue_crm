class Clients::HomeController < ApplicationController
  before_action :authenticate_client!

  def index; end

  def profile
    render json: current_client, serializer: ClientSerializer
  end

  def update_password
    @client = current_client
    if @client.update(client_params)
      bypass_sign_in(@client)
      render json: @client, serializer: ClientSerializer, status: :ok
    else
      render json: { errors: @client.errors }, status: :unprocessable_entity
    end
  end

  private

  def client_params
    params.require(:client).permit(:password, :password_confirmation)
  end
end
