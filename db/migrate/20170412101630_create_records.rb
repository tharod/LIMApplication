class CreateRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :records do |t|
    	t.string :url
      t.string :content
      t.string :link,  array: true, default: []
      t.timestamps
    end
  end
end
