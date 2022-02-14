class AddSlugToNotes < ActiveRecord::Migration[7.0]
  def change
    add_column :notes, :slug, :string

    Note.reset_column_information

    Note.all.each do |n|
      n.slug = SecureRandom.alphanumeric(6)
      n.save
    end
  end
end
