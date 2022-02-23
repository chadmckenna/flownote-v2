json.extract! folder, :id, :name, :user_id, :files, :created_at, :updated_at
json.url folder_url(folder, format: :json)
json.files do
  json.array!(folder.files) do |file|
    json.id file.id
    json.url url_for(file)
  end
end
