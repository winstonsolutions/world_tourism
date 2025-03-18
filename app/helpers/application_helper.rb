module ApplicationHelper
  # Determines the appropriate Bootstrap color class for the navbar
  # based on the current controller
  def navbar_color
    case controller_name
    when 'countries'
      'bg-primary'    # Blue for countries
    when 'cities'
      'bg-success'    # Green for cities
    when 'attractions'
      'bg-info'       # Light blue for attractions
    when 'search'
      'bg-warning'    # Yellow for search
    when 'pages'
      'bg-secondary'  # Gray for about page
    else
      'bg-primary'    # Default blue
    end
  end
  
  # Determines whether to use dark or light text on the navbar
  # based on the background color
  def navbar_text_color
    %w[bg-light bg-warning bg-info].include?(navbar_color) ? 'navbar-dark' : 'navbar-dark'
  end
end
