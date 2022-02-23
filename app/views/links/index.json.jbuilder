json.array!(@links) do |link|
  json.extract! link, :search_title, :title, :type, :url
end
