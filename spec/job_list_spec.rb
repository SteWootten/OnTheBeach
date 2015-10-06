require 'spec_helper'

describe JobList do

	describe '#new' do

		it "returns an instance of JobList object" do
			expect(JobList.new "a =>").to be_instance_of(JobList)			
		end

		it "takes only 1 argument" do
			expect{JobList.new "a =>", "bad_arg"}.to raise_error(ArgumentError)
		end

	end

	describe '#jobs' do

		it "returns an empty sequence given no jobs" do
			job_list = JobList.new ""
			expect(job_list.jobs).to eql ""
		end

		it "returns the job when only given 1 job" do
			job_list = JobList.new "a =>\n"
			expect(job_list.jobs).to eql "a"
		end

		it "returns a sequence of jobs when there are no dependencies" do
			job_list = JobList.new "a =>\nb =>\nc =>\n"
			expect(job_list.jobs).to eql "abc"
		end

		it "returns a sequence where 'c' is before 'b' when 'b' is dependant on 'c'" do
			job_list = JobList.new "a =>\nb => c\nc =>\n"
			expect(job_list.jobs).to eql "acb"
		end

		it "returns a sequence where 'c' is before 'b', 'f' is before 'c', 'a' is before 'd', and 'b' is before 'e' when there are multiple dependencies" do
			job_list = JobList.new "a =>\nb => c\nc => f\nd => a\ne => b\nf =>\n"
			expect(job_list.jobs).to eql "afcbde"
		end

		context "job_id and dependancy_id are the same" do

			it "exits the application when a SelfDependancyError is raised" do
				expect{JobList.new "a => a\n"}.to raise_error(SystemExit)
			end

			it "outputs a message to stdout" do
				expect{
					begin JobList.new "a => a\n"
					rescue SystemExit
					end
				}.to output("Sorry, a can't be dependant on itself\n").to_stdout
			end
			
		end

		context "jobs with circular dependencies" do
			
			it "exits the application when a CircularDependancyError is raised with a simple circular dependancy" do
				expect{JobList.new "a => b\nb => c\nc => a\n"}.to raise_error(SystemExit)
			end

			it "exits the application when a CircularDependancyError is raised with a longer circular dependancy" do
				expect{JobList.new "a =>\nb => c\nc => f\nd => a\ne =>\nf => b"}.to raise_error(SystemExit)
			end

			it "outputs the exception message to stdout" do
				expect{
					begin JobList.new "a => b\nb => c\nc => a\n"
					rescue SystemExit
					end
				}.to output("Circular dependancy detected!\n").to_stdout
			end
		end
	end

end