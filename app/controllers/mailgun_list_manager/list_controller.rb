require_dependency "mailgun_list_manager/application_controller"

module MailgunListManager
  class ListController < ApplicationController

    def index
      @lists = List.all
    end

    def add
      List.add(list_params[:address], list_params)
      @lists = List.all
    end

    def delete
      Mailgun().lists.delete list_member_params["list_address"]
      @lists = List.all
    end

    def update
      p params
      Mailgun().lists.update params[:old_list_address], list_params["address"], list_params
      @list = List.find_by_address list_params["address"]
      @i = params["dom_id"]
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
      params[:list].permit(:description, :address, :name, :access_level)
    end

    def list_member_params
      params.permit(:member_address, :list_address, :list_name, :dom_id)
    end

  end
end
