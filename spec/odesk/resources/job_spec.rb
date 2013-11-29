# encoding: utf-8
require_relative '../../spec_helper'
require 'json'

describe Odesk::Job do
  before do
    @json = File.open('spec/fixtures/job.json', 'r') { |f| JSON.load(f) }
    @job = Odesk::Job.new(@json)
  end

  it 'should be initialized with a hash of attributes' do
    @job.must_be_instance_of Odesk::Job
  end

  it 'should have a hash of string attributes' do
    Odesk::Job::STRING_ATTRS.keys.must_equal [
       :assignment_info, :company_id, :country, :description_digest,
       :description, :engagement, :id, :job_category_seo, :title
      ]
  end

  Odesk::Job::STRING_ATTRS.each do |attr, key|
    it "should have #{attr} set" do
      @job.send(attr).must_equal @json[key]
    end
  end

end
