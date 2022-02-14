class AddPublicToNotes < ActiveRecord::Migration[7.0]
  def change
    add_column :notes, :public, :boolean, default: false
  end
end
