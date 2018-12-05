class CreateEsports < ActiveRecord::Migration[5.2]
  def change
    create_table :esports do |t|
      t.string :name
      t.string :category

      t.timestamps
    end
  end
end
