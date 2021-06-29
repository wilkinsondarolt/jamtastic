class ApplicationController < ActionController::Base
  before_action :set_raven_context
  skip_before_action :verify_authenticity_token, if: :devise_controller?

  private

  def validate_params(contract_class)
    contract_class.new.call(params.permit!.to_h)
  end

  def set_raven_context
    Raven.user_context(id: session[:current_user_id])
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
