class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.string :name, null: false, default: ''
      t.integer :status, null: false, default: 0
      t.string :subject, null: false, default: ''
      t.string :email, null: false, default: ''
      t.text :content
      t.references :user
      t.timestamps
    end
  end
end
