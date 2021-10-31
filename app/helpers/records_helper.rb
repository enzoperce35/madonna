module RecordsHelper
  def readable(date)
    date.to_date.strftime('%b %e')
  end
end
