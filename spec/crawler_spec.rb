require_relative '../script'

RSpec.describe Crawler do
	subject(:crawler) { Crawler.new(document_collection, url_collection)}

	# let(:url) {"/wikia/dragon_age_2"}
	# let (:url_fetcher){UrlFetcher.new}
	# let (:content) {url_fetcher.fetch(:url)}
	# let(:document) {Document.new(:url, :content)}
	let(:document_collection) {DocumentCollection.new}
	let(:url_collection) {BreadthFirstUrlCollection.new}
	# let(:set) {Set.new}
	

	describe "#done_crawling?"  do
		it "should return true when url_collection is empty" do 
			expect(crawler.done_crawling?).to be(true)
		end

	describe
	end
end
