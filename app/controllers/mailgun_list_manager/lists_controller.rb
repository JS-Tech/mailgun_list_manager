require_dependency "mailgun_list_manager/application_controller"

module MailgunListManager
  class ListsController < ApplicationController

    def index
      @lists = List.all
    end

    def create
      List.add(list_params[:address], list_params)
      @lists = List.all
    end

    def update
      list = List.find(params[:id])
      @list = list.update(list_params)
      @old_id = params[:id]
    end

    def destroy
      List.destroy(params[:id])
      @lists = List.all
    end

    private

    def list_params
      params[:list].permit(:description, :address, :name, :access_level)
    end

  end
end
