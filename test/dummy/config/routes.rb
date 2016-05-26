Rails.application.routes.draw do

  mount MailgunListManager::Engine => "/mailgun_list_manager"
end
