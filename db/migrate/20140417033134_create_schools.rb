class CreateSchools < ActiveRecord::Migration
  def change
  		create_table :schools do |t|
	  	t.string :description
	    t.date :date
	    t.timestamps
	  end
  end
end
