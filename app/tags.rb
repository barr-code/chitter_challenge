class Tag
	include DataMapper::Resource

	property :id, Serial
	property :content, String
	has n, :cheeps, :through => Resource

end