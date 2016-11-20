module MailgunListManager
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    load_and_authorize
  end
end
