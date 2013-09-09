class AddPasswordResetToOperators < ActiveRecord::Migration
  def change
    add_column :operators, :password_reset_token, :string
    add_column :operators, :password_reset_sent_at, :datetime
  end
end
