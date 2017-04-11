class AddRepositoryNameToTriggers < ActiveRecord::Migration[5.0]
  def change
    add_column :triggers, :repository_name, :string
  end
end
