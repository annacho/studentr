class FixAwards < ActiveRecord::Migration
  def change
  	drop_table :awards

  	create_table :awards do |t|
  		t.string :name
  		t.string :organization
  		t.string :description
  		t.date :date
  		t.timestamps
		end
  end
end
