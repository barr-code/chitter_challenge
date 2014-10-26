class Cheep

	include DataMapper::Resource

	property :id, Serial
	property :content, String
	property :created_at, DateTime
	
	has n, :tags, :through => Resource
	has 1, :user, :through => Resource

end