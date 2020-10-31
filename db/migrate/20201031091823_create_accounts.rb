class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :account_type
      t.integer :customer_id
      t.date   :open_date
      t.string :customer_name
      t.string :branch
      t.column :minor_indicator, "char(1)"  
      t.timestamps
    end
    add_foreign_key :accounts, :users, column: :customer_id
  end
end
