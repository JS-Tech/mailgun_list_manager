require_dependency "mailgun_list_manager/application_controller"

module MailgunListManager
  class ListController < ApplicationController

    def index
      @lists = Mailgun().lists.list
    end

    def add
      Mailgun().lists.create list_params[:address], list_params
      @lists = Mailgun().lists.list
    end

    def delete
      Mailgun().lists.delete list_member_params["list_address"]
      @lists = Mailgun().lists.list
    end

    def update
      Mailgun().lists.update params[:old_list_address], list_params["address"], list_params
      # @dom_id = params["dom_id"]
      # p list_params
      @list = Mailgun().lists.find(list_params["address"])["list"]
      p @list
      @i = params["dom_id"]
      p '#######################'
      p 'update'
      p '########################'
    end

    def add_member
      @list_address = list_member_params["list_address"]
      @dom_id = list_member_params["dom_id"]
      Mailgun().list_members(@list_address).add list_member_params["member_address"]
    end

    def delete_member
      @list_address = list_member_params["list_address"]
      @dom_id = list_member_params["dom_id"]
      Mailgun().list_members(@list_address).remove list_member_params["member_address"]
    end

    def destroy
    end

    private

    def list_params
      params.permit(:description, :address, :name, :access_level)
    end

    def list_member_params
      params.permit(:member_address, :list_address, :list_name, :dom_id)
    end

  end
end
