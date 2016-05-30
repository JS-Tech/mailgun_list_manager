module MailgunListManager
  class List
    include ActiveModel::Model
    require "base64"

    ACCESS_LEVELS = ["readonly", "members", "everyone"]

    attr_accessor :address,
                  :name,
                  :description,
                  :access_level,
                  :created_at,
                  :members_count

    validates :address, presence: true
    validates_format_of :address, :with => /@/
    validates :access_level, inclusion: { in: ACCESS_LEVELS, messages: "unknown access level type" }
    validates :members_count, :numericality => { :greater_than_or_equal_to => 0 }

    def id
      Base64.urlsafe_encode64(address)
    end

    def members
      json = Mailgun().list_members(address).list
      Member.parse_json(json, self)
    end

    # CRUD operations

    def self.all
      json = Mailgun().lists.list
      @lists = parse_json(json)
    end

    def self.add(address, params)
      Mailgun().lists.create(address, params)
    end

    def self.find(id)
      address = Base64.urlsafe_decode64(id)
      json = Mailgun().lists.find(address)["list"]
      List.new(json)
    end

    def self.destroy(id)
      address = Base64.urlsafe_decode64(id)
      Mailgun().lists.delete(address)
    end

    def update(list_params)
      json = Mailgun().lists.update(address, list_params["address"], list_params)
      List.new(json["list"])
    end

    private

    def self.parse_json(json)
      a = Array.new
      json.each do |list|
        a << List.new(list)
      end
      a
    end

  end
end
