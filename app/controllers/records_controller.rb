class RecordsController < ApplicationController
	include Content
	before_action :valid_url, only: :create
 
	def index
		records = Record.all.as_json(:only => ["content", "url", "link"])
		render json: records.to_json
	end


	def create
		url =	record_params[:url]
		parse_content = parse_content(url)
		if parse_content[:success]
			links = parse_content[:link]
			content = parse_content[:content]
			record = Record.new(url: url, link: links, content: content)
			if record.save
	 			render json: { status: "success", status_code: 200 }
		  else
	      render json: { status: 'failed', message: record.errors, status_code: 400}
		  end
		else
  		render json: { status: "failed", message: parse_content[:messsage], status_code: 404}
  	end
	end

	private
	  
	  def record_params
	    params.require(:record).permit(:url)
	  end

	  def valid_url 
	  	begin	
		    url = URI.parse(record_params[:url])
		    render json: { status: 'failed', message: "URL is not valid", status_code: 400 } unless url.kind_of?(URI::HTTP)
	    rescue Exception => e
	    	render json: { status: 'failed', message: e.message, status_code: 400 }
	    end  
	  end

end


