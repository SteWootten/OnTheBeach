require_relative "exceptions/self_dependancy_error"

class Job

	attr_reader :job_id, :dependancy_id

	def initialize job_id, dependancy_id
		@job_id = job_id
		self.dependancy_id = dependancy_id
	end

	def dependancy_id=(new_dependancy_id)
		raise SelfDependancyError, "Sorry, #{new_dependancy_id} can't be dependant on itself" if @job_id == new_dependancy_id
		@dependancy_id = new_dependancy_id
	end

end