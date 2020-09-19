class Api::V1::Clients::HomeController < ApplicationController

  before_action :authenticate_client!

  def show
    render json: current_client.to_json
  end
end
