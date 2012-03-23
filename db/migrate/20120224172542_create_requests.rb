class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :title
      t.string :status
      t.references :requestor

      t.timestamps
    end
    add_index :requests, :requestor_id
  end
end
