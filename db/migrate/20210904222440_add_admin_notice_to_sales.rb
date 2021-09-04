class AddAdminNoticeToSales < ActiveRecord::Migration[6.1]
  def change
    add_column :sales, :admin_notice, :text
  end
end
