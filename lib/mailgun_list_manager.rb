require "mailgun_list_manager/engine"

module MailgunListManager
  mattr_accessor :apikey
  mattr_accessor :domain

  class << self

    def configure
      yield self
      true
    end
    alias :config :configure
  end
end
