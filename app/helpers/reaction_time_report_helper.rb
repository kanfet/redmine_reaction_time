module ReactionTimeReportHelper

  def overdue_time(issue)
    if issue.closed_on.present?
      distance_of_time_in_words(issue.closed_on, issue.created_on)
    else
      distance_of_time_in_words(Time.now, issue.created_on)
    end
  end

end
