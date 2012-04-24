class CreateRequestStateJoinTable < ActiveRecord::Migration
  def up
    create_table :request_states, :id => false do |t|
      t.integer :request_id
      t.integer :state_id
      t.text :note
      t.timestamps
    end
    add_index :request_states, [:request_id, :state_id]
  end

  def down
    drop_table :request_states
  end
end
