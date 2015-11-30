class UsersController < ApplicationController
  before_filter :authenticate_access!
  before_filter :check_user, :except => [:index]
  load_and_authorize_resource

  def authenticate_access!
    if client_session.blank?
      authenticate_user!
    else
      authenticate_client!
    end
  end
  
  def index
    @users = current_user.role.super_admin == true ? User.order("id DESC").paginate(:page => params[:page]) : User.where("branch_id = #{current_user.branch_id} and id != 1").order("id DESC").paginate(:page => params[:page])
    @all_users = current_user.role.super_admin == true ? User.all : User.where("branch_id = #{current_user.branch_id} and id != 1")
    
    respond_to do |format|
      format.html # index.html.erb
      if params[:all]
        format.json { render json: @all_users }
        format.csv { render text: @all_users.to_csv }
        format.xls { send_data @all_users.to_csv(col_sep: "\t") }
      else
        format.json { render json: @users }
        format.csv { render text: @users.to_csv }
        format.xls { send_data @users.to_csv(col_sep: "\t") }
      end
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    if signed_in?
      @user = User.new
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @user }
      end
    else
      flash[:error] = "Usted no tiene permiso para accesar a esta pagina."
      redirect_to root_path
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
  
  def check_user
    if params[:id] == '1'
      flash[:error] = t"not_authorized"
      redirect_to root_path
    end
  end
  
end
