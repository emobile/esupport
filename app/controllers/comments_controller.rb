class CommentsController < ApplicationController
  before_filter :authenticate_access!, :except => [:new, :create, :show]
  load_and_authorize_resource

  def authenticate_access!
    if client_session.blank?
      authenticate_user!
    else
      authenticate_client!
    end
  end
  
  def index
    @comments = current_user.role.super_admin == true ? Comment.order("id DESC").paginate(:page => params[:page]) : Comment.where(:branch_id => current_user.branch_id).order("id DESC").paginate(:page => params[:page])
    @all_comments = current_user.role.super_admin == true ? Comment.all : Comment.where(:branch_id => current_user.branch_id)
    
    respond_to do |format|
      format.html # index.html.erb
      if params[:all]
        format.json { render json: @all_comments }
        format.csv { render text: @all_comments.to_csv }
        format.xls { send_data @all_comments.to_csv(col_sep: "\t") }
      else
        format.json { render json: @comments }
        format.csv { render text: @comments.to_csv }
        format.xls { send_data @comments.to_csv(col_sep: "\t") }
      end
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(params[:comment])

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: t("wactions.created",  model: t("activerecord.models.#{controller_name.singularize.gsub(" ", "")}"))}
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to @comment, notice:  t("actions.updated",  model: t("activerecord.models.#{controller_name.singularize.gsub(" ", "")}"))}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
    end
  end
end
