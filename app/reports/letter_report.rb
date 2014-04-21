class LetterReport < Ruport::Controller

  #stage :header
  stage :multi_table_report
  def setup

  end

  class Html < Ruport::Formatter
    renders :html, :for => LetterReport

    #def build_header
    #  output << "<h1>Time Report</h1>"
    #end

    build :multi_table_report do
      data.each { |table| pad(10) { draw_table(table) } }
      render_pdf
    end

  end

end