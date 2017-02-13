class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.references :user, index: true, foreign_key: true
      t.references :ip  , index: true, foreign_key: true
    end
  end
end
