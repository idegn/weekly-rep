class WeeklyReportsController < ApplicationController
  before_action :set_weekly_report, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /weekly_reports
  # GET /weekly_reports.json
  def index
    @weekly_reports = WeeklyReport.all.includes([:user,:group])
  end

  def group_index
    @weekly_reports = Group.find(params[:group_id]).weekly_reports.includes(:user)
    render action: :index
  end

  def user_index
    @weekly_reports = User.find(params[:user_id]).weekly_reports.includes(:group)
    render action: :index
  end

  # GET /weekly_reports/1
  # GET /weekly_reports/1.json
  def show
  end

  # GET /weekly_reports/new
  def new
    @weekly_report = WeeklyReport.new
    @weekly_report.setup(current_user)
  end

  # GET /weekly_reports/1/edit
  def edit
  end

  def preview
    render html: Qiita::Markdown::Processor.new.call(params[:content])[:output].to_s.html_safe
  end
  # POST /weekly_reports
  # POST /weekly_reports.json
  def create
    @weekly_report = WeeklyReport.new(weekly_report_params)
    @weekly_report.user = current_user
    @weekly_report.group = current_user.group

    respond_to do |format|
      if @weekly_report.save
        format.html { redirect_to @weekly_report, notice: 'Weekly report was successfully created.' }
        format.json { render :show, status: :created, location: @weekly_report }
      else
        format.html { render :new }
        format.json { render json: @weekly_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weekly_reports/1
  # PATCH/PUT /weekly_reports/1.json
  def update
    respond_to do |format|
      if @weekly_report.update(weekly_report_params)
        format.html { redirect_to @weekly_report, notice: 'Weekly report was successfully updated.' }
        format.json { render :show, status: :ok, location: @weekly_report }
      else
        format.html { render :edit }
        format.json { render json: @weekly_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weekly_reports/1
  # DELETE /weekly_reports/1.json
  def destroy
    @weekly_report.destroy
    respond_to do |format|
      format.html { redirect_to weekly_reports_url, notice: 'Weekly report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weekly_report
      @weekly_report = WeeklyReport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weekly_report_params
      params.require(:weekly_report).permit(:user_id, :content, :reporting_time)
    end
end
