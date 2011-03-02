class TopicsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :all]

  # GET /topics
  # GET /topics.xml
  def all
    @topics = Topic.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @topics }
    end
  end

  def index
    @topics = Topic.find_all_by_user_id(current_user)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @topics }
    end
  end



  # GET /topics/1
  # GET /topics/1.xml
  def show
    @topic = Topic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @topic }
    end
  end

  # GET /topics/new
  # GET /topics/new.xml
  def new
    @topic = Topic.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(:first,:conditions=>["topics.id = ? and topics.user_id = ? ", params[:id], current_user.id])
    unless @topic
      flash[:notice] = "Blog Access Restricted!"
      redirect_to root_url

    end
  end

  # POST /topics
  # POST /topics.xml
  def create
    @topic = Topic.new(params[:topic])
    @topic.user = current_user
    respond_to do |format|
      if @topic.save
        format.html { redirect_to(@topic, :notice => 'Topic was successfully created.') }
        format.xml  { render :xml => @topic, :status => :created, :location => @topic }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.xml
  def update
    @topic = Topic.find(params[:id])
    if @topic.user_id == current_user.id
      respond_to do |format|
        if @topic.update_attributes(params[:topic])
          format.html { redirect_to(@topic, :notice => 'Topic was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
        end
      end
    else
      flash[:notice] = "Blog Access Restricted!"
      redirect_to root_url
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.xml
  def destroy
    @topic = Topic.find(params[:id])
    if @topic.user_id == current_user.id
      @topic.destroy
      respond_to do |format|
        format.html { redirect_to(topics_url) }
        format.xml  { head :ok }
      end
    else
       flash[:notice] = "Blog Access Restricted!"
       redirect_to root_url
    end



  end
end

