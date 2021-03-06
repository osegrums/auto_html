AutoHtml.add_filter(:vimeo).with(:width => 440, :height => 248, :show_title => false, :show_byline => false, :show_portrait => false) do |text, options|
  text.gsub(/(https?):\/\/(www.)?vimeo\.com\/([A-Za-z0-9._%-]*)((\?|#)\S+)?/) do
    protocol = $1
    vimeo_id = $3
    width  = options[:width]
    height = options[:height]
    show_title      = "title=0"    unless options[:show_title]
    show_byline     = "byline=0"   unless options[:show_byline]  
    show_portrait   = "portrait=0" unless options[:show_portrait]
    wmode           = "wmode=#{options[:wmode]}" if options[:wmode]
    frameborder     = options[:frameborder] || 0
    query_string_variables = [show_title, show_byline, show_portrait, wmode].compact.join("&")
    query_string    = "?" + query_string_variables unless query_string_variables.empty?
    if options[:thumbnail]
      img = %{<img src="#{options[:default_thumbnail]}" alt="#{vimeo_id}" data-url="http://vimeo.com/api/v2/video/#{vimeo_id}.json" />}
      icon = %{<span class="vimeo-icon"></span>}
      thumbnail = %{<a class="vimeo-thumbnail" href="#open_video">#{img}#{icon}</a>}
    end

    %{#{thumbnail}<iframe src="#{protocol}://player.vimeo.com/video/#{vimeo_id}#{query_string}" width="#{width}" height="#{height}" frameborder="#{frameborder}"></iframe>}
  end
end
