class ApplicationController < ActionController::Base
  def index; end

  def after_sign_in_path_for(resource)
    if resource.is_a?(Staff)
      staffs_root_path
    elsif resource.is_a?(Client)
      clients_root_path
    else
      root_path
    end
  end
end
