require 'spec_helper'

describe JobList do

	describe '#new' do

		it "returns an instance of JobList object" do
			expect(JobList.new).to be_instance_of(JobList)			
		end

	end

end