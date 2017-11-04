class RenameTriggersModifiedFileToModifiedPath < ActiveRecord::Migration[5.1]
  def change
    rename_column :triggers, :modified_file, :modified_path
  end
end
