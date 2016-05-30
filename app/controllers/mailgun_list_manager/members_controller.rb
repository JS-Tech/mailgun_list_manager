require_dependency "mailgun_list_manager/application_controller"

module MailgunListManager
  class MembersController < ApplicationController

    def create
      Member.add(params[:list_id], params[:member_address])
      @list = List.find(params[:list_id])
    end

    def destroy
      Member.delete(params[:list_id], params[:id])
      @list = List.find(params[:list_id])
    end

  end
end
