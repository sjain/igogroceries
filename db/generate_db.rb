require 'init'

class Store < ActiveRecord::Base
end

response = RestClient.get 'http://localhost:3000/api/v1/stores.json'
stores_json = JSON.parse(response.to_str)
usa_mappings = USStates.new
stores_json.each do |store_hash|
  store = Store.find_by_remote_id(store_hash['remote_id'])
  state_code = store_hash.delete('state')
  store_hash[:state_code] = state_code
  if state_code
    store_hash[:state_name] = usa_mappings.to_name(state_code)
  else
    puts "not state_code for #{store_hash.inspect}"
  end
  if store
    store.update_attributes!(store_hash)
  else
    store = Store.create(store_hash)
  end
end

