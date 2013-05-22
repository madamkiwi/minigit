class CreateWorkspaces < ActiveRecord::Migration
  def change
    create_table :workspaces do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
