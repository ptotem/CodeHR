class LettersController < InheritedResources::Base

  private

    def letter_params
      params.require(:letter).permit(:file)
    end
end

