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
			job_and_dependancy = job.gsub(/\s+/, "").split("=>", -1) # -1 limit arg ensures array of 2 elements are created
			array_of_job_objects << Job.new(job_and_dependancy[0], job_and_dependancy[1])
		end
		
		circular_dependancies?(array_of_job_objects.reject { |job| job.dependancy_id == "" })
		@jobs = order_jobs(array_of_job_objects)

	rescue SelfDependancyError, CircularDependancyError => e
		puts e.message
		abort
	end

	def jobs
		@jobs.empty? ? "" : @jobs.collect { |job| job.job_id }.join("")
	end

	private

	def order_jobs(array_of_job_objects)
		jobs_with_dependancy = array_of_job_objects.select { |job| job.dependancy_id != "" }

		jobs_with_dependancy.each do |dependant_job|
			dependacy_index = array_of_job_objects.find_index {|job| dependant_job.dependancy_id == job.job_id}
			dependant_index = array_of_job_objects.find_index {|job| dependant_job.job_id == job.job_id}

			array_of_job_objects.insert(dependant_index, array_of_job_objects.delete_at(dependacy_index)) if dependacy_index > dependant_index
		end

		return array_of_job_objects
	end

	def circular_dependancies?(array_of_job_objects)
		job_and_dependancy = Hash.new

		array_of_job_objects.each do |job|
			x_id = recursive_find(job_and_dependancy, job.job_id)
			y_id = recursive_find(job_and_dependancy, job.dependancy_id)

			raise CircularDependancyError, "Circular dependancy detected!" if x_id == y_id

			# no circular dependancy so add dependancy to job for next cycle check
			job_and_dependancy[x_id] = y_id
		end
	end

	def recursive_find(job_and_dependancy, id)
		return id if job_and_dependancy[id].nil? # returns id if no dependancy for that job yet
		recursive_find(job_and_dependancy, job_and_dependancy[id]) # if there is a dependancy we recursivley find the dependancies depandancy
	end

end