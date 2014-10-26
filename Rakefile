require 'data_mapper'
require './app/datamapper_setup'
require './app/models/users'
require './app/models/cheeps'
require './app/models/tags'

task :auto_upgrade do 
	DataMapper.auto_upgrade!
	puts "Auto-upgrade complete (no data loss)"
end

task :auto_migrate do 
	DataMapper.auto_migrate!
	puts "Auto-migrate complete (data could have been lost)"
end