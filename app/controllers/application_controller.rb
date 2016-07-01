class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception
  before_action :authenticate_user!

  include Pundit

  #after_action :verify_authorized, except: :index, unless: :devise_controller? #une fois qu on est passé dans le Controller ==> executé pour chaque action de tous les controller
  #after_action :verify_policy_scoped, only: :index, unless: :devise_controller? #une fois qu on est passé dans le Controller ==> executé pour chaque action de tous les controller

  after_action :verify_authorized, except: :index, unless: :devise_or_pages_or_admin_controller? #une fois qu on est passé dans le Controller ==> executé pour chaque action de tous les controller
  after_action :verify_policy_scoped, only: :index, unless: :devise_or_pages_or_admin_controller? #une fois qu on est passé dans le Controller ==> executé pour chaque action de tous les controller

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def devise_or_pages_or_admin_controller?
    devise_controller? || (self.kind_of? RailsAdmin::ApplicationController)
  end

  def user_not_authorized
    flash[:notice] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end


  def default_url_options
  { host: ENV['HOST'] || 'localhost:3000' }
  end
  #Par défaut, Rails retourne le chemin relatif de vos URLs (routing helpers suffixés en _path).
  #Il est donc primordial de lui dire de retourner les urls absolues afin que celles-ci puissent être récupérées par Facebook et Twitter.

end
