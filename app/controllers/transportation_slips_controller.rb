class TransportationSlipsController < ApplicationController
  before_filter :authenticated_admin_and_user
  before_filter :set_locale

uses_tiny_mce :only => [:edit, :new],
                :options => {
                        :theme => 'advanced',
                        :theme_advanced_resizing => true,
                        :theme_advanced_resize_horizontal => false,
                        :plugins => %w{ table fullscreen safari spellchecker pagebreak style layer save advhr advimage advlink emotions iespell inlinepopups insertdatetime preview media searchreplace print contextmenu paste directionality noneditable visualchars nonbreaking xhtmlxtras template },

               :theme_advanced_buttons1 => %w{ save newdocument | bold italic underline strikethrough | justifyleft justifycenter justifyright justifyfull | styleselect formatselect fontselect fontsizeselect },
               :theme_advanced_buttons2 => %w{ cut copy paste pastetext pasteword | search replace | bullist numlist | outdent indent blockquote | undo redo | link unlink anchor image cleanup help code | insertdate inserttime preview | forecolor backcolor },
               #:theme_advanced_buttons3 => %w{ tablecontrols | hr removeformat visualaid | sub sup | charmap emotions iespell media advhr | print | ltr rtl | fullscreen },
               #:theme_advanced_buttons4 => %w{ insertlayer moveforward movebackward absolute | styleprops spellchecker | cite abbr acronym del ins attribs | visualchars nonbreaking template blockquote pagebreak | insertfile insertimage },
               :theme_advanced_toolbar_location => "top",
               :theme_advanced_toolbar_align => "left",
               :theme_advanced_statusbar_location => "bottom"
                 }

  # GET /transportation_slips
  # GET /transportation_slips.xml
  def index
    @search = TransportationSlip.search(params[:search])
    @transportation_slips = @search.all(:order => "id DESC").paginate(:page => params[:page], :per_page => 50)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @transportation_slips }
    end
  end

  # GET /transportation_slips/1
  # GET /transportation_slips/1.xml
  def show
    @transportation_slip = TransportationSlip.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @transportation_slip }
    end
  end

  # GET /transportation_slips/new
  # GET /transportation_slips/new.xml
  def new
    @transportation_slip = TransportationSlip.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @transportation_slip }
    end
  end

  # GET /transportation_slips/1/edit
  def edit
    @transportation_slip = TransportationSlip.find(params[:id])
  end

  # POST /transportation_slips
  # POST /transportation_slips.xml
  def create
    @transportation_slip = TransportationSlip.new(params[:transportation_slip])

    respond_to do |format|
      if @transportation_slip.save
        format.html { redirect_to(@transportation_slip, :notice => 'TransportationSlip was successfully created.') }
        format.xml  { render :xml => @transportation_slip, :status => :created, :location => @transportation_slip }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @transportation_slip.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /transportation_slips/1
  # PUT /transportation_slips/1.xml
  def update
    @transportation_slip = TransportationSlip.find(params[:id])

    respond_to do |format|
      if @transportation_slip.update_attributes(params[:transportation_slip])
        format.html { redirect_to(@transportation_slip, :notice => 'TransportationSlip was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @transportation_slip.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def preview
    @transportation_slip = TransportationSlip.find(params[:id])
    render :layout => false
  end

  # DELETE /transportation_slips/1
  # DELETE /transportation_slips/1.xml
  def destroy
    @transportation_slip = TransportationSlip.find(params[:id])
    @transportation_slip.destroy

    respond_to do |format|
      format.html { redirect_back_or_default(transportation_slips_url) }
      format.xml  { head :ok }
    end
  end
end
