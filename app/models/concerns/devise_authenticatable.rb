module DeviseAuthenticatable
  extend ActiveSupport::Concern

  included do
    devise :database_authenticatable, :recoverable, :rememberable, :validatable
  end
end
