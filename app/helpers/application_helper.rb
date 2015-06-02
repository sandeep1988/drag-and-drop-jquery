module ApplicationHelper
	def title
      base_title = "Ruby on Rails Tutorial Sample App"
      if @title.nil?
         base_title
      else
         "Test Sandeep"
      end
   end
end
