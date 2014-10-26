class Tag
	include DataMapper::Resource

	property :id, Serial
	property :text, String
	has n, :cheeps, :through => Resource

end