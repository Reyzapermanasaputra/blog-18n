class Article < ActiveRecord::Base
	def self.import(file)
	  spreadsheet = open_spreadsheet(file)
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      parameters = ActionController::Parameters.new(row)
      article = find_by_title(row["title"]) || new
      article.update!(parameters.permit(:title, :body, :status))
	  end
    end

	def self.open_spreadsheet(file)
	  case File.extname(file.original_filename)
	  when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
 	  when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
      else raise "Unknown file type: #{file.original_filename}"
      end
    end
end
