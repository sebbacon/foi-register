class CreateRequestors < ActiveRecord::Migration
  def change
    create_table :requestors do |t|
      t.string :name
      t.string :email
      t.text :notes   # including telephone numbers, street address, etc.

      t.timestamps
    end
  end
end
