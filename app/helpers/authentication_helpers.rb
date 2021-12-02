module AuthenticationHelpers
  JWT_COOKIE_KEY = "jwt".freeze

  # Simulate cookies when this helper is used outside controllers (like graphiql)
  def cookies
    begin
      super
    rescue
      context.nil? ? {} : context[:cookies]
    end
  end

  def jwt_cookie
    cookie = cookies[JWT_COOKIE_KEY]
    JWT.decode(cookie, Rails.application.secret_key_base, true, { algorithm: "HS256" }).first if cookie.present?
  end

  def current_user
    User.find(jwt_cookie["user_id"]) if jwt_cookie.present?
  end

  def signed_in?
    jwt_cookie.present?
  end

  def signed_in_as?(user)
    current_user == user
  end

  def sign_in_as(user)
    encoded = JWT.encode({ user_id: user.id, signed_in_at: Time.now }, Rails.application.secret_key_base, "HS256")
    if cookies.is_a? Rack::Test::CookieJar
      cookies[JWT_COOKIE_KEY] = encoded
    else
      cookies[JWT_COOKIE_KEY] = { value: encoded, same_site: :lax }
    end
  end

  def sign_out
    cookies.delete JWT_COOKIE_KEY
  end
end
