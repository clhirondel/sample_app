module ApplicationHelper
  # Retourner un titre basé sur la page.
  def title
    base_title = "Simple App du Tutoriel Ruby on Rails"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def logo
    image_tag("bfg_logo.jpg", :alt => "Sample App", :class => "round")
  end
  
  def get_date(date_value)
    date_value.strftime("%d/%m/%Y") 
  end
  
  def get_time(time_value)
    time_value.strftime("%H:%M") 
  end
  
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == params[:sort] && params[:direction] == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end
end
