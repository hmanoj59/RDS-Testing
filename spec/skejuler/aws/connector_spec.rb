require 'spec_helper'

describe Skejuler::Aws::Connector do

  it 'can be initialized using IAM Role'
  it 'can be initialized using API Key'

  it 'should return a list of partitions' do
    expect(Skejuler::Aws::Connector.partitions).to be_kind_of(Array)
  end

  it 'should return a list of region for given partition' do
    expect(described_class.regions('aws')).to be_kind_of(Array)
  end

end
