class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :open_new_client

  private

  def open_new_client
    connection = WeddingApi::Connection.new
  end
end
