require_relative '../script'

RSpec.describe DocumentCollection do
	subject(:document_collection) { DocumentCollection.new }

	it "let's me add a document" do
		document_collection.add_document(Document.new('www.something.com', 'stuff'))
		expect(document_collection.size).to eq(1)
	end
end