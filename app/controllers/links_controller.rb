class LinksController < ApplicationController
  before_action :authenticate_user!

  def index
    notes_links = current_user.notes.map do |note|
      {
        search_title: "Notes/#{note.title}",
        title: note.title,
        url: url_for(note),
        type: 'url',
      }
    end
    folder_links = current_user.folders.flat_map do |folder|
      folder.files.flat_map do |file|
        {
          search_title: "#{folder.name}/#{file.filename}",
          title: file.filename,
          url: file.variable? ? url_for(file.variant(resize_to_limit: [768, 1024])) : url_for(file),
          type: file.content_type.match(/image/) ? 'img' : 'url'
        }
      end
    end

    @links = [*notes_links, *folder_links]
  end
end
