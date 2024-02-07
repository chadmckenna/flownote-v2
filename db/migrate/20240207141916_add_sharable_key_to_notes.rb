class AddSharableKeyToNotes < ActiveRecord::Migration[7.0]
  def change
    add_column :notes, :sharable_key, :uuid
  end
end
