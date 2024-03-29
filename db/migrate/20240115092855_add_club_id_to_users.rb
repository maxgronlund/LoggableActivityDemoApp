# frozen_string_literal: true

class AddClubIdToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :demo_club_id, :integer
    # Add foreign key constraint
    add_foreign_key :users, :demo_clubs, column: :demo_club_id
  end
end
