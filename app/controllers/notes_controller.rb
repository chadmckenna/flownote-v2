class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_note, only: %i[ show edit update destroy ]

  # GET /notes or /notes.json
  def index
    @tag_names = Tag.where(user: current_user).order('name ASC').map(&:name).uniq
    @notes = Note.where(user: current_user).order('updated_at DESC')
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

  # GET /notes/1 or /notes/1.json
  def show
    respond_to do |format|
      format.html
      format.json
      format.md { render plain: @note.to_markdown }
    end
  end

  # GET /notes/new
  def new
    @note = Note.new(user: current_user)
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes or /notes.json
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

  # PATCH/PUT /notes/1 or /notes/1.json
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

  # DELETE /notes/1 or /notes/1.json
  def destroy
    @note.destroy

    respond_to do |format|
      format.html { redirect_to notes_url, notice: "Note was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find_by!(id: params[:id], user: current_user)
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:title, :content).merge(user_id: current_user.id)
    end
end
