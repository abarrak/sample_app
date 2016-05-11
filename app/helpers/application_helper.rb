module ApplicationHelper

  # Returns the full title on a per-page basis. # Documentation comment
  def full_title page_title = ''
    base_title = "RoR Tutorial Sample App"
    (page_title.empty? ? base_title : "#{page_title} | #{base_title}")
  end

end
