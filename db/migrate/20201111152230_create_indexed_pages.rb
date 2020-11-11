class CreateIndexedPages < ActiveRecord::Migration[6.0]
  def change
    create_table :indexed_pages do |t|
      t.string :url, uniqueness: true
      t.string :title
      t.integer :domain_id

      t.timestamps
    end
  end
end
