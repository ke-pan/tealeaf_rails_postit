module ApplicationHelper

  def fix_url(str)
    str.start_with?("http://") ? str : "http://#{str}"
  end

  def format_time(time)
    if logged_in?
      time = time.in_time_zone(current_user.timezone)
    end
    
    time.strftime("%m/%d/%Y %l:%M%P %Z")
  end

  def test_vote?(object)
    !logged_in? || object.votes.find_by(creator: current_user).nil?
  end
end
