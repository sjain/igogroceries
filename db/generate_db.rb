require 'init'

class USState < ActiveRecord::Base
end

class Store < ActiveRecord::Base
  belongs_to :us_state
end


response = RestClient.get 'http://localhost:3000/api/v1/stores.json'
stores_json = JSON.parse(response.to_str)
usa_mappings = USStates.new
stores_json.each do |store_hash|
  store = Store.find_by_remote_id(store_hash['remote_id'])
  state_code = store_hash['state']
  us_state = USState.find_by_code(state_code)
  unless us_state
    us_state = USState.create(
      :code => state_code,
      :name => usa_mappings.to_name(state_code)
    )
  end
  store_hash[:us_state_id] = us_state.id
  if store
    store.update_attributes!(store_hash)
  else
    store = Store.create(store_hash)
  end
end

