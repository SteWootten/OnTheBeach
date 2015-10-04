class Job

	attr_reader :job_id, :dependant_id

	def initialize job_id, dependant_id
		@job_id = job_id
		@dependant_id = dependant_id
	end

end