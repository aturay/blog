class CreateRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :ratings do |t|
      t.integer :num
      t.references :post, index: true, foreign_key: true
    end
  end
end
