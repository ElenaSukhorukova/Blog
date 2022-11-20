class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.string :status
      t.references :commentabable, polymorphic: true

      t.timestamps
    end
  end
end
