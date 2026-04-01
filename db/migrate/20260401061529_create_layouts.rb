class CreateLayouts < ActiveRecord::Migration[8.1]
  def change
    create_table :layouts do |t|
      t.string :name

      t.timestamps
    end
  end
end
