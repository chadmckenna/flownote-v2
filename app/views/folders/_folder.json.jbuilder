json.extract! folder, :id, :name, :created_at, :updated_at
json.url folder_url(folder, format: :json)
json.files do
  json.array!(folder.files) do |file|
    json.id file.id
    json.filename file.filename
    json.url url_for(file)
  end
end
