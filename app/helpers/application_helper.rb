module ApplicationHelper

	def error_messages_for(object)
		render(partial: 'application/error_messages', locals: { object: object })
	end	

	def pretty_datetime(object)
		object.strftime("%d %b %Y %H:%M:%S")
	end

end
