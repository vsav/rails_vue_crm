class Staffs::ClientsController < ApplicationController
  before_action :authenticate_staff!
  before_action :find_client, only: [:update, :destroy]

  def index
    clients = Client.all
    render json: clients, each_serializer: ClientFullSerializer
  end

  def create
    client = Client.new(client_params)

    if client.save
      render json: client, serializer: ClientSerializer, status: :created
    else
      render json: { errors: client.errors }, status: :unprocessable_entity
    end
  end

  def update
    organizations_ids = params[:organizations].pluck(:id)
    if @client.update(client_params)
      @client.organization_ids = organizations_ids
      render json: @client, serializer: ClientFullSerializer, status: :ok
    else
      render json: { errors: @client.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @client.destroy
  end

  def validate_uniqueness
    phone = Client.find_by(phone: params[:phone])
    email = Client.find_by(email: params[:email])

    if phone && email
      render json: { uniqueness: { phone: "Phone #{params[:phone]} already exists",
                                    email: "Email #{params[:email]} already exists" }
                   }
    elsif phone
      render json: { uniqueness: { phone: "Phone #{params[:phone]} already exists" }}
    elsif email
      render json: { uniqueness: { email: "Email #{params[:email]} already exists" }}
    else
      render json: { uniqueness: {} }
    end
  end

  private

  def client_params
    params.require(:client).permit(:email,
                                   :full_name,
                                   :phone,
                                   :password,
                                   :password_confirmation)
  end

  def find_client
    @client = Client.find(params[:id])
  end
end
