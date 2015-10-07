require_relative 'job'

class JobList

	def initialize list_of_jobs
		self.jobs = list_of_jobs
	end

	def jobs=(list_of_jobs)
		return @jobs = [] if list_of_jobs == ""

		new_jobs = list_of_jobs.split("\n")

		all_jobs = []

		new_jobs.each do |job|
			job_and_dependancy = job.gsub(/\s+/, "").split("=>", -1) # -1 limit arg ensures array of 2 elements are created
			all_jobs << Job.new(job_and_dependancy[0], job_and_dependancy[1])
		end
		
		circular_dependancies?(all_jobs.reject { |job| job.dependancy_id == "" })
		@jobs = order_jobs(all_jobs)

	rescue SelfDependancyError, CircularDependancyError => e
		puts e.message
		abort
	end

	def jobs
		@jobs.empty? ? "" : @jobs.collect { |job| job.job_id }.join("")
	end

	private

	def order_jobs(all_jobs)
		jobs_with_dependancy = all_jobs.select { |job| job.dependancy_id != "" }

		jobs_with_dependancy.each do |dependant_job|
			dependacy_index = all_jobs.find_index {|job| dependant_job.dependancy_id == job.job_id}
			dependant_index = all_jobs.find_index {|job| dependant_job.job_id == job.job_id}

			all_jobs.insert(dependant_index, all_jobs.delete_at(dependacy_index)) if dependacy_index > dependant_index
		end

		return all_jobs
	end

	def circular_dependancies?(all_jobs)
		job_and_dependancy = Hash.new

		all_jobs.each do |job|
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