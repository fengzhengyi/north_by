module ApplicationHelper
  def embedded_svg(filename, options = {})
    asset = Rails.application.assets.find_asset(filename)

    if asset
      file = asset.source.force_encoding("UTF-8")
      doc = Nokogiri::HTML::DocumentFragment.parse file
      svg = doc.at_css "svg"
      svg["class"] = options[:class] if options[:class].present?
    else
      "<!-- SVG #{filename} not found -->"
    end

    raw doc
  end

  def color_for(ticket, user)
    case ticket.status
    when "unsold" then "bg-white"
    when "held"
      ticket.user == user ? "bg-red-600" : "bg-yellow-500"
    when "purchased"
      ticket.user == user ? "bg-green-600" : "bg-yellow-500"
    end
  end
end
