require_relative '../script'

RSpec.describe DocumentCollection do
	subject(:document_collection) { DocumentCollection.new }

	it "lets you add a document" do
		document_collection.add_document(Document.new('/wiki/dragon_age_origins', 'stuff'))
		expect(document_collection.size).to eq(1)
	end
end
