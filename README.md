**This gem is discontinued and no longer maintained**

# Mailgun list manager

A web interface to interact with mailgun's mailling lists.

## Installation

`gem 'mailgun_list_manager', '~> 0.0.1'`

Add to your config file the following:

```
MailgunListManager.configure do |config|
  # Mailgun API key
  config.apikey = Rails.application.secrets.mailgun_api_key
  # Mailgun domain
  config.domain = Rails.application.secrets.mailgun_domain
end
```

Navigate to **/mailgun_list_manager** and enjoy editing your mailing lists.
**Important** do not forget to secure the entry point since anyone accessing the
page will be able to freely edit, remove or add groups.

## Features

* List mailling lists
* Edit lists' informations
* List members of a list
* Add a member to a list
* Remove a member from a list
* Create a list
* Remove a list
* Print a list
