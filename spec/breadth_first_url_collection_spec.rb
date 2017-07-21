require_relative '../script'

RSpec.describe BreadthFirstUrlCollection do
	subject(:url_collection) { BreadthFirstUrlCollection.new }

	it "lets you add a url and store it as the next link" do
		url_collection.add_url("/first")
		expect(url_collection.size).to eq(1)
		expect(url_collection.next_url).to eq("http://dragonage.wikia.com/first")
	end
end
