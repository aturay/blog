class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :login, index:true
      t.references :ip, index: true, foreign_key: true
    end
  end
end
