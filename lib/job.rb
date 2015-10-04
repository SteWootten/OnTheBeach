require_relative "exceptions/self_dependancy_error"

class Job

	attr_reader :job_id, :dependant_id

	def initialize job_id, dependant_id
		@job_id = job_id
		self.dependant_id = dependant_id
	end

	def dependant_id=(new_dependant_id)
		raise SelfDependancyError, "Sorry, #{new_dependant_id} can't be dependant on itself" if @job_id == new_dependant_id
		@dependant_id = new_dependant_id
	end

end