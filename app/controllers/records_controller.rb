class RecordsController < ApplicationController
  def index
    user_start = params[:start]
    user_end = params[:end]
    
    @begin_date = user_start.nil? ? Date.today - 7.days : user_start.to_date

    @end_date = user_end.nil? ? Date.yesterday : user_end.to_date
    
    @records = Record.where(created_at: @begin_date.beginning_of_day..@end_date.end_of_day).order(:created_at)
  end

  def show
  end
end
