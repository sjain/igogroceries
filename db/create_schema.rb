require 'init'

ActiveRecord::Schema.define do
  create_table :stores, :force => true do |t|
    t.string :remote_id
    t.string :name
    t.string :domain
    t.string :address1
    t.string :address2
    t.string :city
    t.string :state_code
    t.string :state_name
    t.string :zip
    t.string :phone
  end

  add_index :stores, :remote_id
  add_index :stores, :name
  add_index :stores, :domain
  add_index :stores, :state_code
  add_index :stores, :state_name
  add_index :stores, :zip

end
