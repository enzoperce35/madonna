class RecordsController < ApplicationController
  def index
    user_start = params[:start]
    user_end = params[:end]
    
    @begin_date = user_start.nil? ? Date.today - 6.days : user_start

    @end_date = user_end.nil? ? Date.yesterday : user_end
    
    @records = Record.where(created_at: @begin_date..@end_date)
  end

  def show
  end
end
