class CreateTvs < ActiveRecord::Migration[6.0]
  def change
    create_table :tvs do |t|
      t.string :title
      t.string :time
      t.text :overview
      t.text :detail
      t.string :act
      t.timestamps
    end
  end
end
