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

		jobs_with_dependancy = array_of_job_objects.select { |job| job.dependant_id != "" }

		jobs_with_dependancy.each do |dependant_job|
			dependacy_index = array_of_job_objects.find_index {|job| dependant_job.dependant_id == job.job_id}
			dependant_index = array_of_job_objects.find_index {|job| dependant_job.job_id == job.job_id}

			array_of_job_objects.insert(dependant_index, array_of_job_objects.delete_at(dependacy_index))
		end
		@jobs = array_of_job_objects

	rescue SelfDependancyError => e
		puts e.message
		abort
	end

	def jobs
		return "" if @jobs.length == 0
		@jobs.collect { |job| job.job_id }.join("")
	end

end