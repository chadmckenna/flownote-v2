class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @query = params[:query]
    @notes = Note.where(user: current_user).basic_search(@query)
  end
end
