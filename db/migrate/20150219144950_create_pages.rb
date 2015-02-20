class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.text :body
      t.string :path
      t.string :ancestry
      # t.timestamps null: false
    end
    add_index :pages, :ancestry
    add_index :pages, :path
  end
end
