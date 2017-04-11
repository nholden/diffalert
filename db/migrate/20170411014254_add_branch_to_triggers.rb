class AddBranchToTriggers < ActiveRecord::Migration[5.0]
  def change
    add_column :triggers, :branch, :string
  end
end
