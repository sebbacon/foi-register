class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.timestamps
      
      t.text :private_part, :null => false
      t.text :public_part, :null => false
      t.references :request
    end
  end
end
