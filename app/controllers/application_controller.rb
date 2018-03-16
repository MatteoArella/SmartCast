class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception, prepend: true
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :authenticate_user!

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  private

  def set_locale
    I18n.default_locale = extract_locale || I18n.default_locale
    #if language_change_necessary?
    #  I18n.locale = the_new_locale
    #  set_locale_cookie(I18n.locale)
    #else
    #  use_locale_from_cookie
    #end
  end

  def language_change_necessary?
    cookies['language'].nil? || params[:language]
  end

  def the_new_locale
    new_locale = params[:language]
    if I18n.available_locales.include?(new_locale)
      new_locale
    else
      I18n.default_locale.to_s
    end
  end

  def set_locale_cookie(locale)
    cookies['language'] = locale.to_s
  end

  def use_locale_from_cookie
    I18n.locale = cookies['language']
  end

  def extract_locale
    params[:language]
  end
end
