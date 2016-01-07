class Document < ActiveRecord::Base

  def format
  	sleep 2
  	update_column :imported, true
  end
end
