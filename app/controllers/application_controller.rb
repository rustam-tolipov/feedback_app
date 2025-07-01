class ApplicationController < ActionController::Base
  include Pagy::Backend
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :sanitize_pagy_page

  private

  def sanitize_pagy_page
    if params[:page].present? && params[:page].to_i < 1
      params[:page] = 1
    end
  end
end
