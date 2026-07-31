class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }
  helper_method :current_user, :user_signed_in?
  before_action :authenticate_user

  private

  def current_user
    return @current_user if defined?(@current_user)

    @current_user = if request.format.json?
        current_user_from_jwt
      else
        current_user_from_cookie
      end
  end

  def current_user_from_jwt
    auth_header = request.headers["Authorization"]
    return nil if auth_header.blank?

    scheme, token = auth_header.split(" ", 2)
    return nil unless scheme&.casecmp("Bearer")&.zero?
    return nil if token.blank?

    begin
      decoded = JsonWebToken.decode(token)
      return nil unless decoded

      user_id = decoded[:user_id] || decoded["user_id"]
      User.find_by(id: user_id)
    rescue JWT::DecodeError, JWT::ExpiredSignature, JWT::VerificationError
      nil
    end
  end

  def current_user_from_cookie
    user_id = cookies.encrypted[:user_id]
    return nil if user_id.blank?
    User.find_by(id: user_id)
  end

  def user_signed_in?
    current_user.present?
  end

  def authenticate_user
    return if current_user.present?

    respond_to do |format|
      format.html do
        redirect_to new_session_path, alert: "You must be signed in"
      end
      format.json do
        render json: { error: "Unauthorized" }, status: :unauthorized
      end
      format.any { head :unauthorized }
    end
  end

  def redirect_if_authenticated
    redirect_to root_path, notice: "You are already logged in" if user_signed_in?
  end
end