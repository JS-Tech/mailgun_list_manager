require_dependency "mailgun_list_manager/application_controller"

module MailgunListManager
  class ListController < ApplicationController

    def index
      @lists = List.all
      p @lists.first.members
    end

    def add
      List.add(list_params[:address], list_params)
      @lists = List.all
    end

    def delete
      List.find_by_address(params["address"]).delete
      @lists = List.all
    end

    def update
      list = List.find_by_address(params["address"])
      @list = list.update(list_params)
      @i = params["dom_id"]
    end

    def add_member
      @dom_id = list_member_params["dom_id"]
      Member.add(list_member_params["list_address"], list_member_params["member_address"])
      @list = List.find_by_address(list_member_params["list_address"])
    end

    def delete_member
      @dom_id = list_member_params["dom_id"]
      Member.delete_by_addresses(list_member_params["list_address"], list_member_params["member_address"])
      @list = List.find_by_address(list_member_params["list_address"])
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
