class AddUsernameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :username, :string, unique: true

    User.reset_column_information

    User.all.each do |u|
      u.username = SecureRandom.alphanumeric(6)
      u.save
    end
  end
end
