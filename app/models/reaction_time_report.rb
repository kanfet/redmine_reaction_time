class ReactionTimeReport

  attr_accessor :start_date, :end_date

  def initialize(attributes = {})
    attrs = attributes || {}
    attrs.each do |name, value|
      send("#{name}=", value)
    end
  end

  def start_date_as_time
    Time.parse(start_date).midnight
  rescue ArgumentError
    nil
  end

  def end_date_as_time
    Time.parse(end_date).midnight + 86399.seconds # end of day
  rescue ArgumentError
    nil
  end

  def overdue_issues
    @overdue_issues ||= begin
      issues = Issue.includes(:priority).includes(:project).
        order('projects.name, enumerations.position DESC, issues.created_on')
      issues = with_period_conditions(issues)
      issues.select do |issue|
        estimated_time = issue.created_on + 2.hours
        (issue.closed_on.blank? && Time.now > estimated_time) || (issue.closed_on && issue.closed_on > estimated_time)
      end
    end
  end

  def overdue_percent
    issues = Issue.scoped
    issues = with_period_conditions(issues)
    (100 * overdue_issues.length / issues.count).round(2)
  end

  private

  def with_period_conditions(issues_relation)
    issues_relation = issues_relation.where('issues.created_on >= ?', start_date_as_time) if start_date_as_time.present?
    issues_relation = issues_relation.where('issues.created_on <= ?', end_date_as_time) if end_date_as_time.present?
    issues_relation
  end

end