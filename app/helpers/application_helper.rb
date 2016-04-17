module ApplicationHelper

  def bs_submit(f)
    value = params[:action] == 'new' ? '作成' : '更新'
    f.submit value, class: 'btn btn-primary pull-right'
  end

  def gravatar_for(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    link_to image_tag(gravatar_url, alt: user.name, class: 'gravatar'), users_weekly_reports_path(user)
  end

  def link_to_users_weekly_reports(user)
    link_to user.name, users_weekly_reports_path(user), class: :user_name
  end
end
