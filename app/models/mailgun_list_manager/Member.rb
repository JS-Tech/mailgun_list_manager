module MailgunListManager
  class Member
    include ActiveModel::Model
    require "base64"

    attr_accessor :address,
                  :name,
                  :subscribed,
                  :vars,
                  :list

    validates :address, presence: true
    validates_format_of :address, :with => /@/
    validates :subscribed, inclusion: { in: [true, false], messages: "must be true or false" }

    def initialize(attributes = {}, list)
      super(attributes)
      @list = list
    end

    def id
      Base64.urlsafe_encode64(address)
    end

    # CRUD operations

    def self.add(list_id, address)
      list_address = Base64.urlsafe_decode64(list_id)
      Mailgun().list_members(list_address).add(address)
    end

    def self.delete(list_id, id)
      list_address = Base64.urlsafe_decode64(list_id)
      address = Base64.urlsafe_decode64(id)
      Mailgun().list_members(list_address).remove(address)
    end

    private

    def self.parse_json(json, list)
      p json
      a = Array.new
      json.each do |member|
        a << Member.new(member, list)
      end
      a
    end

  end
end
