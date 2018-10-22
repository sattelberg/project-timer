class ApplicationController < ActionController::Base
  $salt = "dunkaroos"
  protect_from_forgery with: :exception
  include SessionsHelper
end
