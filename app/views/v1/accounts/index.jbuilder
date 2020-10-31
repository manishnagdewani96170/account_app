json.accounts @accounts do |account|
  json.partial! "v1/accounts/account", account: account
end
