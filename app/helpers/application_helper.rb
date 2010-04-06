# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # Returns title of a page with defoult value
  def title
    base_title ="Test application"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{h@title}"
    end
  end

  def logo
     image_tag( 'logo.png', :alt => 'Sample application', :class => 'round')
  end
end
