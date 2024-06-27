require('zip')

class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_note, only: %i[ show edit update destroy history make_public make_private]

  include Paginate

  def index
    @tag_names = Tag.where(user: current_user).order('name ASC').map(&:name).uniq
    @notes = paginate(
      Note
        .includes(:tags)
        .where(user: current_user)
        .order('updated_at DESC')
    )
  end

  def export
    notes = Note.includes(:tags).where(user: current_user).order('created_at DESC')

    zip_filestream = Zip::OutputStream.write_buffer do |zio|
      notes.each do |note|
        name = "#{note.title.gsub(/[^0-9a-zA-Z]/, '').underscore}.md"
        zio.put_next_entry(name)
        zio.write note.content
      end
    end

    zip_filestream.rewind

    send_data zip_filestream.read, filename: "#{DateTime.now.to_i}_archive.zip"
  end

  def by_tag
    @nested_tag_names = params[:names].split('/')
    @tag_names = Tag.where(user: current_user).order('name ASC').map(&:name).uniq
    @notes = @nested_tag_names.map do |name|
      Note
        .joins(:tags)
        .where(user: current_user)
        .where(tags: { name: name })
    end.reduce(:&)
    @possible_tag_names = @notes.flat_map(&:tags).flat_map(&:name).uniq.sort - @nested_tag_names
  end

  def show
    respond_to do |format|
      format.html
      format.json
      format.md { render plain: @note.to_markdown }
    end
  end

  def history
    @history = @note.history
  end

  def new
    @note = Note.new(user: current_user)
  end

  def edit
  end

  def create
    @note = Note.new(note_params)

    respond_to do |format|
      if @note.save
        format.html { redirect_to note_url(@note), notice: "Note was successfully created." }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to note_url(@note), notice: "Note was successfully updated." }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @note.destroy

    respond_to do |format|
      format.html { redirect_to notes_url, notice: "Note was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def make_public
    respond_to do |format|
      if @note.update(public: true)
        format.html { redirect_to note_url(@note), notice: "Note was successfully set to public." }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def make_private
    respond_to do |format|
      if @note.update(public: false)
        format.html { redirect_to note_url(@note), notice: "Note was successfully set to private." }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_note
      @note = Note.find_by!(id: params[:id], user: current_user)
    end

    def note_params
      params.require(:note).permit(:title, :content).merge(user_id: current_user.id)
    end
end
