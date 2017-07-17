class UrlCollection
	def initialize
		@arr = []
	end

	def next_url
		@next_url = @arr.shift
		@next_url
	end

	def add_url(url)
		@arr << url
	end

	def size
		@arr.size
	end

	def empty?
		@arr.empty?
	end
end
