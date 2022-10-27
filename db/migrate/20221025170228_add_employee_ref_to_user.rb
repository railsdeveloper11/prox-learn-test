class AddEmployeeRefToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :employment, foreign_key: true
  end
end
