class SetSharableKeys < ActiveRecord::Migration[7.0]
  def up
    Note.all.each do |note|
      note.sharable_key = SecureRandom.uuid
      note.save
    end
  end

  def down
    Note.all.each do |note|
      note.sharable_key = nil
      note.save
    end
  end
end
