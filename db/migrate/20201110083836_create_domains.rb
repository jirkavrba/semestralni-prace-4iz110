class CreateDomains < ActiveRecord::Migration[6.0]
  def change
    create_table :domains do |t|
      t.string :url, unique: true
      t.string :status, default: :not_indexed
      t.datetime :last_indexed_at, null: true

      t.timestamps
    end
  end
end
