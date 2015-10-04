require 'spec_helper'

describe Job do

	describe '#new' do

		it "returns and instance of Job object" do
			expect(Job.new "a", "b").to be_instance_of(Job)		
		end

		it "takes only 2 arguments" do
			expect{Job.new ""}.to raise_error(ArgumentError)
		end

	end

	describe '#job' do

		it "returns the job" do
			job = Job.new "a", "b"
			expect(job.job).to eql "a"			
		end

	end

	describe '#dependant' do
	  
		it "returns the jobs dependant job" do
			job = Job.new "a", "b"
			expect(job.dependant).to eql "b"
		end

	end

end