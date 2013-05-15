require 'init'

ActiveRecord::Schema.define do

  create_table :us_states, :force => true do |t|
    t.string :code, :limit => 2
    t.string :name, :limit => 2
  end

  add_index :us_states, :code
  add_index :us_states, :name

  create_table :stores, :force => true do |t|
    t.string :remote_id
    t.string :name
    t.string :domain
    t.string :address1
    t.string :address2
    t.string :city
    t.string :state
    t.integer :us_state_id
    t.string :zip
    t.string :phone
  end

  add_index :stores, :remote_id
  add_index :stores, :name
  add_index :stores, :domain
  add_index :stores, :state
  add_index :stores, :us_state_id
  add_index :stores, :zip

end
