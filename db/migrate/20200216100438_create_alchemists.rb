class CreateAlchemists < ActiveRecord::Migration[6.0]
  def change
    create_table :alchemists do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.string :display_name
      t.text :bio
      t.string :roles, array: true, null: false, default: [ 'editor' ]
      t.string :alchemy_language, null: false, default: 'en'
      t.string :password_digest
      t.string :password_reset_token
      t.integer :creator_id
      t.integer :updater_id
      t.text :cached_tag_list

      t.timestamps
    end
    add_index :alchemists, :creator_id
    add_index :alchemists, :updater_id
  end
end
