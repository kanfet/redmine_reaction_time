class ReactionTimeReportController < ApplicationController
  unloadable

  def show
    @report = ReactionTimeReport.new(params[:report]) if params[:commit]
  end
end
