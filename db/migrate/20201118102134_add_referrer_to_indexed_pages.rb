class AddReferrerToIndexedPages < ActiveRecord::Migration[6.0]
  def change
    add_column :indexed_pages, :referrer, :string, null: true
  end
end
