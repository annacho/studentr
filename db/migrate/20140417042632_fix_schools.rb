class FixSchools < ActiveRecord::Migration
  def change
  	 	drop_table :schools

	  	create_table :schools do |t|
	  	t.string :level
	  	t.string :name
	    t.date :date
	    t.timestamps
	  end
  end
end
