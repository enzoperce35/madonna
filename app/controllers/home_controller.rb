class HomeController < ApplicationController
  def index
    @sales_today = Sale.where("DATE(created_at) = ?", Date.today).order(created_at: :desc)
  end
end