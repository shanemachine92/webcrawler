require_relative '../script'

RSpec.describe Document do

	subject(:document) { Document.new("www.somepage.com", "<h1>a header</h1><p>some text yay</p><a href = 'www.facebook.com/wiki/some_page/great'> an a tag</a><a href = '/wiki/this_page/'>another a tag</a><a href = 'www.wikipedia.com/'>taggy tag</a><a href = 'www.facebook.com/wiki/some_page/great'>dupe tag</a>") }

	describe "#domain_hrefs" do
		it "grabs only domain specific hrefs from the content" do 
			expect(document.domain_hrefs).to eq(["/wiki/this_page/"])
		end
	end
end
