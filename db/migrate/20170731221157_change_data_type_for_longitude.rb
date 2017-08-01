class ChangeDataTypeForLongitude < ActiveRecord::Migration[5.1]
  def change
    change_column(:stores, :longitude, :float)
  end
end
