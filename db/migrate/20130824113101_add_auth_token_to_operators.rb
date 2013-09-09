class AddAuthTokenToOperators < ActiveRecord::Migration
  def change
    add_column :operators, :auth_token, :string
  end
end
