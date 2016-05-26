module MailgunListManager
  class Engine < ::Rails::Engine
    require 'mailgun'
    require 'jquery-rails'

    isolate_namespace MailgunListManager
  end
end
