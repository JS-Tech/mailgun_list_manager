module MailgunListManager
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    load_and_authorize(controller: "mailgun_list_manager")
  end
end
