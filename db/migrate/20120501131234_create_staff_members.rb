class CreateStaffMembers < ActiveRecord::Migration
  def change
    create_table :staff_members do |t|
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
