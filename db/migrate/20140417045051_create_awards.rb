class CreateAwards < ActiveRecord::Migration
  def change
  		create_table :awards do |t|
	  	t.string :description
	  	t.string :organization
	    t.date :date
	    t.timestamps
  	end
  end
end
