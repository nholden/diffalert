class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :github_events_secret

      t.timestamps
    end
  end
end
