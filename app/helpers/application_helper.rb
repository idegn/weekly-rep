module ApplicationHelper

  def bs_submit(f)
    value = params[:action] == 'new' ? '作成' : '更新'
    f.submit value, class: 'btn btn-primary'
  end

  def write_latest_report_btn
    if current_user.wrote_latest_report?
      link_to '週報を書く', new_weekly_report_path, class: 'btn btn-primary btn-lg'
    end
  end

  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: 'gravatar')
  end
end
