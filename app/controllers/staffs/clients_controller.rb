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

  def validate_uniqueness
    phone = Client.find_by(phone: client_params[:phone])
    email = Client.find_by(email: client_params[:email])

    if phone && email
      render json: { validations: { phone: "Phone #{client_params[:phone]} already exists",
                                    email: "Email #{client_params[:email]} already exists" }
                   }
    elsif phone
      render json: { validations: { phone: "Phone #{client_params[:phone]} already exists" }}
    elsif email
      render json: { validations: { email: "Email #{client_params[:email]} already exists" }}
    else
      render json: { validations: {} }
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
end
