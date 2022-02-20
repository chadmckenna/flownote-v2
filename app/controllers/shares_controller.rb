class SharesController < ApplicationController
  before_action :set_share_user

  include Paginate

  def show
    @note = Note.find_by!(slug: params[:slug], user: @share_user, public: true)

    respond_to do |format|
      format.html
      format.json
      format.md { render plain: @note.to_markdown }
    end
  end

  def index
    @notes = paginate(Note.where(user: @share_user, public: true).order('updated_at DESC'))
  end

  def by_tag
    @nested_tag_names = params[:names].split('/')
    @notes = @nested_tag_names.map do |name|
      Note
        .joins(:tags)
        .where(user: @share_user, public: true)
        .where(tags: { name: name })
    end.reduce(:&)

    @possible_tag_names = @notes.flat_map(&:tags).flat_map(&:name).uniq.sort - @nested_tag_names
  end

  private
  def set_share_user
    @share_user = User.find_by!(username: params[:user])
  end
end
