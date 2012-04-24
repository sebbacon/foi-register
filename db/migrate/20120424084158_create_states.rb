class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :tag
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
