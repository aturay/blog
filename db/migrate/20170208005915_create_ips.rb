class CreateIps < ActiveRecord::Migration[5.0]
  def change
    create_table :ips do |t|
      t.string :ip, index: true
    end
  end
end
