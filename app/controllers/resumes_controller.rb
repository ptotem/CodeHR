class ResumesController < InheritedResources::Base

  private

    def resume_params
      params.require(:resume).permit(:file)
    end
end

