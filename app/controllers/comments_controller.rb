class CommentsController < ApplicationController

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user

    redirect_to action: 'index' unless @comment.user.group == @comment.weekly_report.group

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.weekly_report, notice: 'Comment was successfully created.' }
      else
        format.html { redirect_to @comment.weekly_report }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:user_id, :weekly_report_id, :content)
    end
end
