class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      # 商品のカラムを下記に実装
      t.integer :genre_id, foreign_key: true, null: false
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :price, null: false
      t.boolean :is_active, default: true, null: false


      t.timestamps
    end
  end
end
