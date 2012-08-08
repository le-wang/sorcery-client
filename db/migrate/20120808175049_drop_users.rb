class DropUsers < ActiveRecord::Migration
  def up
    drop_table :users
  end

  def down
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :crypted_password
      t.string :salt

      t.timestamps
    end
  end
end
