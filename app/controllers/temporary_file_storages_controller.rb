class TemporaryFileStoragesController < InheritedResources::Base

  private

    def temporary_file_storage_params
      params.require(:temporary_file_storage).permit(:file)
    end
end

