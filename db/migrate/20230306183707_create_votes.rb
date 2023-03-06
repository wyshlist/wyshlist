class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :wish, null: false, foreign_key: true

      t.timestamps
    end
  end
end
