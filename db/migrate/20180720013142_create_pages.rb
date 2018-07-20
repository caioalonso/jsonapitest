class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
      t.string :h1
      t.string :h2
      t.string :h3
      t.string :links
      t.string :url

      t.timestamps
    end
  end
end
