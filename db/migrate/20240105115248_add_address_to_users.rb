# frozen_string_literal: true

class AddAddressToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :demo_address_id, :integer
    # Add foreign key constraint
    add_foreign_key :users, :demo_addresses, column: :demo_address_id
  end
end
