class UploadsController < ApplicationController
  before_action :set_upload, only: [:show, :edit, :update, :destroy]

  # GET /uploads
  # GET /uploads.json
  def index
    @uploads = Upload.all
  end

  # GET /uploads/1
  # GET /uploads/1.json
  def show
  end
def new
@upload = Upload.new
end



#===========================================
  # GET /uploads/new
def create
  # @upload = Upload.new
  @upload = Upload.new(upload_params)
  while $REDIS.wait(2,1000) == 0
    puts "Waiting for Slave"
    sleep 10
  end

  $messageno=$messageno+1
  puts $messageno
  puts @upload.messagetext
  puts $REDIS.set("number: #{$messageno}", @upload.messagetext )

  respond_to do |format|
    if @upload.save
      format.html { redirect_to @upload, notice: 'Upload was successfully created.' }
      format.json { render :show, status: :created, location: @upload }
    else
      format.html { render :new }
      format.json { render json: @upload.errors, status: :unprocessable_entity }
    end
  end
end
#============================================================

  # GET /uploads/1/edit
  def edit
  end


  # PATCH/PUT /uploads/1
  # PATCH/PUT /uploads/1.json
  def update
    respond_to do |format|
      if @upload.update(upload_params)
        format.html { redirect_to @upload, notice: 'Upload was successfully updated.' }
        format.json { render :show, status: :ok, location: @upload }
      else
        format.html { render :edit }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.json
  def destroy
    @upload.destroy
    respond_to do |format|
      format.html { redirect_to uploads_url, notice: 'Upload was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_upload
      @upload = Upload.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def upload_params
      params.require(:upload).permit(:messagecode, :messagetext)
    end
end
