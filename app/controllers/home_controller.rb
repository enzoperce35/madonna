class HomeController < ApplicationController
  def index
    @sales_today = Sale.where("DATE(created_at) = ?", Date.today).order(created_at: :desc)
  end

  def show_sale
    @records = Record.where.not("DATE(created_at) = ?", Date.today)
    @today = Record.find_by(created_at: Time.current.beginning_of_day..Time.now)
  end

  def show_record
    @record = Record.find(params[:id])
  end
end