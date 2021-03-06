# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :enable_links

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  # rubocop:disable MethodLength
  def enable_links
    if user_signed_in?
      @enabled_links = [
        { title: 'Posts', dropdown: true, links: [
          { title: 'View Posts', path: posts_path },
          { title: 'Add Post', path: new_post_path }
        ] },
        { title: 'Categories', dropdown: true, path: categories_path, links: [
          { title: 'View Categories', path: categories_path },
          { title: 'Add Category', path: new_category_path }
        ] },
        { title: 'Profile', dropdown: true, links: [
          { title: 'Edit Profile', path: edit_user_registration_path },
          { title: 'Logout', path: destroy_user_session_path, attributes: { rel: 'nofollow', 'data-method': 'delete' } }
        ] }
      ]
    else
      @enabled_links = [
        { title: 'View Posts', path: posts_path },
        { title: 'View Categories', path: categories_path }
      ]
    end
  end
  # rubocop:enable MethodLength
end
