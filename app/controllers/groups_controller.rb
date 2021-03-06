class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy, :requests_index]
  before_action :authenticate_user!
  before_action :validate_group_user, only: [:edit, :update, :destroy]
  before_action :check_belonging, only: [:new, :create]

  def requests_index
    @request_users = @group.request_users
  end

  def approve_request
    @user = User.find(params[:user][:id])

    respond_to do |format|
      if @user.update({ approved: true })
        format.html { redirect_to groups_requests_path(@user.group), notice: "#{@user.name}が#{@user.group.name}に参加しました。" }
      else
        format.html { redirect_to groups_requests_path(@user.group) }
      end
    end
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @users = @group.belonging_users
    @request_users = @group.request_users
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if current_user.update({ group: @group, approved: true })
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def group_params
    params.require(:group).permit(:name, :description, :template, :report_wday, :report_time)
  end

  def validate_group_user
    return if current_user.group == @group
    flash[:alert] = '権限がありません'
    redirect_to action: 'index'
  end

  def check_belonging
    unless current_user.group_id.nil?
      flash[:alert] = 'すでにグループに所属済みです'
      redirect_to action: 'index'
    end
  end

end
