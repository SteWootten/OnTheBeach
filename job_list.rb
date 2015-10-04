require_relative 'job'

class JobList

	def initialize jobs
		self.jobs = jobs
	end

	def jobs=(new_jobs)
		return @jobs = [] if new_jobs == ""

		jobs = new_jobs.split("\n")

		array_of_job_objects = []

		jobs.each do |job|
			job_and_dependant = job.gsub(/\s+/, "").split("=>", -1)
			array_of_job_objects << Job.new(job_and_dependant[0], job_and_dependant[1])
		end
		@jobs = array_of_job_objects
	end

	def jobs
		return "" if @jobs.length == 0
		@jobs.collect { |job| job.job_id }.join("")
	end

end