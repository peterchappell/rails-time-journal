class EntriesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  #before_action :check_user, only: [:show, :edit, :update, :destroy]

  # GET /entries
  # GET /entries.json
  def index
    if params[:date]
      @entries = current_user.entries.where(:user_id => current_user.id, :date => params[:date])
    else
      @entries = current_user.entries
    end
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    @entry = current_user.entries.new
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = current_user.entries.new(entry_params) 

    respond_to do |format|
      if @entry.save
        format.html { redirect_to @entry, notice: 'Entry was successfully created.' }
        format.json { render action: 'show', status: :created, location: @entry }
      else
        format.html { render action: 'new' }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      #@entry = Entry.find(params[:id])
      @entry = current_user.entries.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:entry).permit(:activity_name, :score, :hours, :date)
    end

    def check_user
      if @entry.user_id != current_user.id
        render :text => 'Unauthorised', :status => 403
      end
    end
end
