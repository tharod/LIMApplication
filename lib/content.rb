module Content
  def parse_content(url)
  	request = Typhoeus::Request.new(
      url,
      method: :get,
      ssl_verifypeer: false,
      followlocation: true,
      headers: { ContentType: "application/json"}
    )
    page = request.run
    if page.success?
      doc = Nokogiri::HTML(page.response_body)
      content = doc.css('h1, h2, h3').map(&:text).join(". ").gsub(/\s+/, '')

      links = doc.css('a').map{|a| a["href"]}.compact
  		{ content: content, link: links, success: true }
    else
      { success: false, messsage: page.response_body}
    end
  end
end
