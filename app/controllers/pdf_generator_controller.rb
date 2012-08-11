class PdfGeneratorController < ApplicationController
  before_filter :authenticated_admin
  before_filter :set_locale
  
  def index
    output = Report.new.to_pdf

      respond_to do |format|
        format.pdf do
          send_data output, :filename => "hello.pdf", 
                            :type => "application/pdf",
                            :disposition  => 'inline'
        end
      end

  end

end
