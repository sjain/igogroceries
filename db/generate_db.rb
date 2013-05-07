require 'init'

class Store < ActiveRecord::Base
end

response = RestClient.get 'http://localhost:3000/api/v1/stores.json'
stores_json = JSON.parse(response.to_str)
stores_json.each do |store_hash|
  store = Store.find_by_remote_id(store_hash['remote_id'])
  if store
    store.update_attributes!(store_hash)
  else
    store = Store.create(store_hash)
  end
end

