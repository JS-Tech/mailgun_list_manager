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
    validates :access_level,  inclusion: { in: ACCESS_LEVELS, messages: "unknown access level type" }
    validates :members_count, :numericality => { :greater_than_or_equal_to => 0 }, allow_blank: true

    def id
      Base64.urlsafe_encode64(address)
    end

    def members
      json = Mailgun().list_members(address).list
      Member.parse(json, self)
    end

    # CRUD operations

    def self.all
      json = Mailgun().lists.list
      @lists = parse(json)
    end

    def self.add(address, params)
      p '######'
      p params
      List.new(params)
      Mailgun().lists.create(address, params)
    end

    def self.find(id)
      address = Base64.urlsafe_decode64(id)
      hash = Mailgun().lists.find(address)["list"]
      List.new(hash)
    end

    def self.destroy(id)
      address = Base64.urlsafe_decode64(id)
      Mailgun().lists.delete(address)
    end

    def update(list_params)
      hash = Mailgun().lists.update(address, list_params["address"], list_params)["list"]
      List.new(hash)
    end

    def initialize(params = {})
      super(params)
      raise self.errors.messages.to_s if self.invalid?
    end

    private

    def self.parse(hash)
      hash.map { |list| List.new(list) }
    end

  end
end
