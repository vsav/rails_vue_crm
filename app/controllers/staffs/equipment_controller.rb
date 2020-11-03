class Staffs::EquipmentController < ApplicationController
  before_action :authenticate_staff!
  before_action :find_equipment, only: [:update, :destroy]

  def index
    equipment = Equipment.all
    render json: equipment, each_serializer: EquipmentSerializer
  end

  def create
    equipment = Equipment.new(equipment_params)

    if equipment.save
      render json: equipment, serializer: EquipmentSerializer, status: :created
    else
      render json: { errors: equipment.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @equipment.update(equipment_params)
      render json: @equipment, serializer: EquipmentSerializer, status: :ok
    else
      render json: { errors: @equipment.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @equipment.destroy
  end

  def validate_uniqueness
    serial = Equipment.find_by(serial: params[:serial])
    if serial
      render json: { uniqueness: { serial: "Serial number #{params[:serial]} already exists" }}
    else
      render json: { uniqueness: {} }
    end
  end

  private

  def find_equipment
    @equipment = Equipment.find(params[:id])
  end

  def equipment_params
    params.require(:equipment).permit(:name, :kind, :serial)
  end
end
