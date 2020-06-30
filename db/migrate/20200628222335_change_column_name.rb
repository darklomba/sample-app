class ChangeColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :reser_digest, :reset_digest
  end
end
