# encoding: UTF-8
class LetterReportController < ApplicationController
  def letter
    LetterReport.render_pdf( :file => "foo.pdf", :report_title => "Sample Document" )
  end
end
