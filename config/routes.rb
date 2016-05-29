MailgunListManager::Engine.routes.draw do

  root to: "list#index"

  delete "list/:list_address/members/:member_address", to: "list#delete_member", constraints: { list_address: /[\w+\-.]+@[a-z\d\-.]+\.[a-z]+/i, member_address: /[\w+\-.]+@[a-z\d\-.]+\.[a-z]+/i }

  post "list/members/", to: "list#add_member"

  post   "list", to: "list#add"
  put    "list/:address", to: "list#update", constraints: { address: /[\w+\-.]+@[a-z\d\-.]+\.[a-z]+/i }
  delete "list/:address", to: "list#delete", constraints: { address: /[\w+\-.]+@[a-z\d\-.]+\.[a-z]+/i }

end
