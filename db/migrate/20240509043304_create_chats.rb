class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.references :user, null: false, foreign_key: true
      t.string :message
      t.references :room, null: false, foreign_key: true
      t.timestamps
    end
  end
end
