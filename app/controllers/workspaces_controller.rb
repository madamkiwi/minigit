require 'grit'

class WorkspacesController < ApplicationController
  before_filter :authorize
  def index
    @workspaces = Workspace.all

    r = Grit::Repo.new("/Users/kalai/code/rails32/work2/git/bootstrap")

    @logs = r.log("master", ".", :max_count => 10)

  end

  def show
    @workspace = Workspace.find(params[:id])

    r = Grit::Repo.new("/Users/kalai/code/rails32/work2/git/bootstrap")
   
    r.commits

  end

  def new
    @workspace = Workspace.new
  end

  def edit
  end

  def create
    @workspace = Workspace.new(params[:workspace])

    respond_to do |format|
      if @workspace.save
        Dir.chdir("/Users/kalai/code/rails32/work2/git/bootstrap") do
          r = Grit::Repo.new('.')
          @fname = params[:workspace][:title]
          @workspace.title = @fname.original_filename
          @workspace.save
          File.open(@workspace.title, 'wb') { |f| f.write @fname.read }
          r.add(@workspace.title)
          r.commit_index(@workspace.description)
        format.html { redirect_to @workspace,
          :notice => 'File ' + @workspace.title + ' was successfully added.' }
        format.json { render :json => @workspace, :status => :created,
          :location => @workspace }
        end
      else
        format.html { render :action => "new" }
        format.json { render :json => @workspace.errors,
          :status => :unprocessable_entity }
      end
    end
  end

  def update
    @workspace = Workspace.find(params[:id])

    respond_to do |format|
      if @workspace.update_attributes(params[:workspace])
        format.html { redirect_to @workspace,
          :notice => 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @product.errors,
          :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @workspace = Workspace.find(params[:id])
        Dir.chdir("/Users/kalai/code/rails32/work2/git/bootstrap") do
          r = Grit::Repo.new('.')
          fname = @workspace.title
          r.remove(fname)
          r.commit_index('removed ' + fname)
        end

    @workspace.destroy

    respond_to do |format|
      format.html { redirect_to workspaces_url }
      format.json { head :no_content }
    end
  end

  def edit
    Dir.chdir("/Users/kalai/code/rails32/work2/git/bootstrap") do
      r = Grit::Repo.new('.')
      @head = r.heads.first
      redirect_to diff_workspace_path, :notice => :log.id
    end
  end

  def diff
   Dir.chdir("/Users/kalai/code/rails32/work2/git/bootstrap") do
      r = Grit::Repo.new('.')
      @diff = r.git.show({:full_index => true, :pretty => 'raw'}, params[:id])
    end

  end

end
