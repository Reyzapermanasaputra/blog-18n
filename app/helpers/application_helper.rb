module ApplicationHelper
  def flash_class(key)
  	case key.to_sym
  	  when :notice then "alert alert-success"
  	  when :info then "alert alert-info"
  	  when :danger then "alert alert-danger"
  	  when :warning then "alert alert-warning"
  	  when :error then "alert alert-danger"
  	end
  end
end

