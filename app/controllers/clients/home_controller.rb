class Clients::HomeController < ApplicationController
  before_action :authenticate_client!

  def index; end

  def profile
    render json: current_client, serializer: ClientSerializer
  end
end
