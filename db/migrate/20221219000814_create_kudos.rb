class CreateKudos < ActiveRecord::Migration[7.0]
  def change
    create_table :kudos do |t|
      t.integer :user_id
      t.integer :blog_id

      t.timestamps
    end
  end
end
