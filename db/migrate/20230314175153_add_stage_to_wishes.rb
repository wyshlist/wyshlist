class AddStageToWishes < ActiveRecord::Migration[7.0]
  def change
    add_column :wishes, :stage, :integer, default: 0
  end
end
