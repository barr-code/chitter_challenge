class Tag
	include DataMapper::Resource

	property :id, Serial
	has n, :cheeps, :through => Resource

end