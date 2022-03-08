class FoldersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_folder, only: %i[ show edit update destroy destroy_file ]

  def index
    @folders = Folder.where(user: current_user)
  end

  def show
  end

  def edit
  end

  def create
    @folder = Folder.new(folder_params)

    respond_to do |format|
      if @folder.save
        format.html { redirect_to folders_path, notice: "Folder was successfully created." }
        format.json { render :show, status: :created, location: @folder }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @folder.update(folder_params) && @folder.files.attach(params[:folder][:files])
        format.html { redirect_to folder_url(@folder), notice: "Folder was successfully updated." }
        format.json { render :show, status: :ok, location: @folder }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @folder.destroy

    respond_to do |format|
      format.html { redirect_to folders_url, notice: "Folder was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def destroy_file
    file = @folder.files.find(params[:file_id])
    file.purge

    respond_to do |format|
      format.html { redirect_to folder_path(@folder), notice: "#{file.filename} was successfully destroyed." }
      format.json { head :no_content }
    end

  end

  private
    def set_folder
      @folder = Folder.find_by!(id: params[:id], user: current_user)
    end

    def folder_params
      params.require(:folder).permit(:name).merge(user_id: current_user.id)
    end
end
