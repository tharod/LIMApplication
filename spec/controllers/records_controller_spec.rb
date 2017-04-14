require "rails_helper"

RSpec.describe RecordsController, :type => :controller do
  describe "Post create" do
  	context "Success" do
	    it "has increase the count of the record" do
	    	expect{ post :create, { :record => { :url => "http://www.developersite.org/103-112906-ruby-on-rails" } } }.to change{Record.count}.by(1)
	    end

	    it 'has a success message' do
	    	post :create, { :record => { :url => "http://www.developersite.org/103-112906-ruby-on-rails" } }
	    	response_body = JSON.parse response.body
	    	expect(response_body).to eq ({"status"=>"success", "status_code"=>200})
	    end

	    it "has a 200 status code" do
	    	post :create, { :record => { :url => "http://www.google.com" } }
	    	expect(response.status).to eq 200
	    end

   	end

   	context "Failure" do
   		it "has a 400 status code" do
   			post :create, { :record => { :url => "" } }
	    	res = JSON.parse(response.body)
	    	expect(res["status_code"]).to eq 400
	    end

	    it "should not increase the count of the record" do
	    	expect{ 
	    		post :create, { :record => { :url => "vx98fdf" } }
	    	}.to change{Record.count}.by(0)
	    end
   	end
  end

  describe "get index" do
    it "Get list of created record" do
    	records = create_list(:record, 3)
      get :index
			response_body = JSON.parse(response.body)
			expect(response_body.length).to eq 3
			expect(response_body.sample.keys).to eq ["url", "content", "link"]
			expect( response_body.sample["link"].is_a?(Array)).to eq true
    end

  end
end