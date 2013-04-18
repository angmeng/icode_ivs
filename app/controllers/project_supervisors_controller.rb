class ProjectSupervisorsController < ApplicationController
  # GET /project_supervisors
  # GET /project_supervisors.xml
  def index
    @project_supervisors = ProjectSupervisor.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @project_supervisors }
    end
  end

  # GET /project_supervisors/1
  # GET /project_supervisors/1.xml
  def show
    @project_supervisor = ProjectSupervisor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project_supervisor }
    end
  end

  # GET /project_supervisors/new
  # GET /project_supervisors/new.xml
  def new
    @project_supervisor = ProjectSupervisor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project_supervisor }
    end
  end

  # GET /project_supervisors/1/edit
  def edit
    @project_supervisor = ProjectSupervisor.find(params[:id])
  end

  # POST /project_supervisors
  # POST /project_supervisors.xml
  def create
    @project_supervisor = ProjectSupervisor.new(params[:project_supervisor])

    respond_to do |format|
      if @project_supervisor.save
        format.html { redirect_to(@project_supervisor, :notice => 'ProjectSupervisor was successfully created.') }
        format.xml  { render :xml => @project_supervisor, :status => :created, :location => @project_supervisor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project_supervisor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /project_supervisors/1
  # PUT /project_supervisors/1.xml
  def update
    @project_supervisor = ProjectSupervisor.find(params[:id])

    respond_to do |format|
      if @project_supervisor.update_attributes(params[:project_supervisor])
        format.html { redirect_to(@project_supervisor, :notice => 'ProjectSupervisor was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project_supervisor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /project_supervisors/1
  # DELETE /project_supervisors/1.xml
  def destroy
    @project_supervisor = ProjectSupervisor.find(params[:id])
    @project_supervisor.destroy

    respond_to do |format|
      format.html { redirect_to(project_supervisors_url) }
      format.xml  { head :ok }
    end
  end
end
