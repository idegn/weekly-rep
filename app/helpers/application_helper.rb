module ApplicationHelper

  def bs_submit(f)
    value = params[:action] == 'new' ? '作成' : '更新'
    f.submit value, class: 'btn btn-primary pull-right'
  end

  def wday_options(default = nil)
    options_for_select(t('date.day_names').zip((0..6).to_a), default)
  end

  def report_time_options(default = nil)
    return default if default
    (0..24).flat_map do |h|
      [0, 30].map { |m|  '%02d : %02d' % [h, m]  }
    end
  end

  def gravatar_for(user, size = 50)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    link_to image_tag(gravatar_url, alt: user.name, class: 'gravatar'), users_weekly_reports_path(user)
  end

  def link_to_users_weekly_reports(user)
    link_to user.name, users_weekly_reports_path(user), class: :user_name
  end
end
