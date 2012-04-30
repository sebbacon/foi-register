class AddNotesToLgcsTerms < ActiveRecord::Migration
  def change
    add_column :lgcs_terms, :notes, :text
  end
end
