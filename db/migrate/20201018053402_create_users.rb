class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :account_name, null: false
      t.string :display_name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.text :introduction
      t.boolean :is_valid, default:true, null: false
      t.string :avatar
      t.boolean :admin, default:false
      t.string :activation_digest
      t.boolean :activated, default:false
      t.datetime :activated_at
      t.string :reset_digest
      t.datetime :reset_sent_at
      t.boolean :guest, default:false

      t.timestamps
    end
  end
end
