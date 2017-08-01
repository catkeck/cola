class ChangeDataTypeForLatitude < ActiveRecord::Migration[5.1]
  def change
    change_column(:stores, :latitude, :float)
  end
end
