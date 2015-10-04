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

		it "returns the jobs" do
			job_list = JobList.new "a =>\nb => c"
			expect(job_list.jobs).to eql "a =>\nb => c"
		end

	end

end