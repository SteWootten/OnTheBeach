require_relative 'lib/job_list'

puts "List of jobs please. Put each job on a new line and write 'END' after your last job."

$/ = 'END'

jobs = STDIN.gets.chomp('END')
job_list = JobList.new jobs

puts "Job List:"
puts job_list.jobs