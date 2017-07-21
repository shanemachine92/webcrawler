require_relative '../script'

RSpec.describe Crawler do
	subject(:crawler) { Crawler.new(document_collection, url_collection) }

	let(:document_collection) {DocumentCollection.new}
	let(:url_collection) {BreadthFirstUrlCollection.new}

	describe "#done_crawling?"  do
		it "should return true when url_collection is empty" do 
			expect(crawler.done_crawling?).to be(true)
		end
	end
end
