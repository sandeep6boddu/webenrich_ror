module ApplicationHelper

	def nav_link(link_text, link_path)
		class_name = current_page?(link_path) ? 'active' : ''
		content_tag(:li) do
			link_to link_text, link_path, :class => class_name
		end
	end

	def controller?(*controller)
		controller.include?(params[:controller])
	end

	def action?(*action)
		action.include?(params[:action])
	end

	def bootstrap_class_for flash_type
		{ success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type] || flash_type.to_s
	end

	def flash_messages(opts = {})
		flash.each do |msg_type, message|
			concat(content_tag(:script, message, type: "text/javascript") do
				concat raw("$(document).ready(function(){")
				if message.class.name == 'ActiveModel::Errors'
					concat raw("sweetAlert('Error!', '#{j message.full_messages.to_sentence}', '#{msg_type == 'alert' ? 'error' : ''}');")
				else
					concat raw("sweetAlert('#{msg_type == 'notice' ? 'Success!' : ''}', '#{message}', '#{msg_type == 'alert' ? 'Error!' : ''}', '#{message}', '#{msg_type == 'alert' ? 'error' : ''}', '#{message}', '#{msg_type == 'info' ? 'Info' : 'Info'}', '#{message}');")
				end
				concat raw("});")
			end)
		end
		nil
	end

	def date_format(date)
		date.strftime("%d-%B-%Y")
	end

	def calender_of(portfolio)
		if portfolio.duration == 1
			if portfolio.calender == :months
				return "Month"
			elsif portfolio.calender == :years
				return "Year"
			end
		else
			if portfolio.calender == :months
				return "Months"
			elsif portfolio.calender == :years
				return "Years"
			end
		end
	end
end
