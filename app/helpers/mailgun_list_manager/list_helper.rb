module MailgunListManager
  module ListHelper

    def get_members(list_email)
      Mailgun().list_members(list_email).list
    end

    def encode string
      ActiveSupport::Base64.encode64(string)
    end

    def decode string
      ActiveSupport::Base64.decode64(string)
    end
  end
end
