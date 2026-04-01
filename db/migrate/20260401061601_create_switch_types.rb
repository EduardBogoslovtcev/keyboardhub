class CreateSwitchTypes < ActiveRecord::Migration[8.1]
  def change
    create_table :switch_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
