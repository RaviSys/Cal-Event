require 'zip'

class HomeController < ApplicationController
  
  def index
  end

  def convert_to_zip
  end

  def to_zip
    folder = params[:path_to_zip][:folder_path]
    zip_folder_name = folder + ".zip"
    zip_file = ZipFileGenerator.new(folder, zip_folder_name)
    zip_file.write
    redirect_to zip_path, flash: { success: "Your zip has been prepared successfully. You can find it here: #{zip_folder_name}" }
  end

end
