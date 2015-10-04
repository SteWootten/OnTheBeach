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

end