require 'spec_helper'

describe Job do

	describe '#new' do

		it "returns and instance of Job object" do
			expect(Job.new "a", "b").to be_instance_of(Job)		
		end

		it "takes only 2 arguments" do
			expect{Job.new ""}.to raise_error(ArgumentError)
		end

		it "raises a SelfDependancyError when the job_id is the same as the dependant_id" do
			expect{Job.new "a", "a"}.to raise_error(SelfDependancyError)
		end

	end

	describe '#job' do

		it "returns the job id" do
			job = Job.new "a", "b"
			expect(job.job_id).to eql "a"			
		end

	end

	describe '#dependant' do
	  
		it "returns the jobs dependant job id" do
			job = Job.new "a", "b"
			expect(job.dependant_id).to eql "b"
		end

	end

end