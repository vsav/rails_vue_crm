class ApiTokenStrategy < Warden::Strategies::Base
  def valid?
    api_token.present?
  end

  def authenticate!
    resource = scope.to_s.classify.constantize
    user = resource.find_by(api_token: api_token)

    if user&.valid?
      success!(user)
      update_api_token(user)
    else
      fail!('Invalid email or password')
    end
  end

  private

  def api_token
    env['HTTP_AUTHORIZATION'].to_s.remove('Bearer ')
  end

  def update_api_token(user)
    user.update(api_token: SecureRandom.uuid)
  end
end
