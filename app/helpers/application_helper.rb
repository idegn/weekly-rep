module ApplicationHelper

  def bs_submit(f)
    value = params[:action] == 'new' ? '作成' : '更新'
    f.submit value, class: 'btn btn-primary'
  end
end
