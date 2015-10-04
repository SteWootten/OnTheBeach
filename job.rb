class Job

	attr_reader :job, :dependant

	def initialize job, dependant
		@job = job
		@dependant = dependant
	end

end