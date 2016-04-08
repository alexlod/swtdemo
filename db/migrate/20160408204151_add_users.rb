class AddUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :google_uid
      t.string :name
      t.string :first_name
      t.string :last_name
      t.string :email
      
      t.timestamps
    end
    
    add_index :users, :google_uid, unique: true
  end
end
