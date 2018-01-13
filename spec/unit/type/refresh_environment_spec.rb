require 'spec_helper'

describe Puppet::Type.type(:refresh_environment) do
  let(:resource) { described_class.new(:name => 'after awscli package') }
  let(:provider) { Puppet::Provider.new(resource) }

  before :each do
    resource.provider = provider
  end

  describe 'parameter :name' do
    it 'is a parameter' do
      expect(described_class.attrtype(:name)).to eq(:param)
    end

    it 'is the namevar' do
      expect(resource.parameters[:name]).to be_isnamevar
    end

    it 'has documentation' do
      expect(described_class.attrclass(:name).doc).not_to eq("\n\n")
    end

    it 'cannot be set to nil' do
      expect {
        resource[:name] = nil
      }.to raise_error(Puppet::Error, %r{Got nil value for name})
    end

  end

  describe '#refresh' do
    it 'calls refresh_environment_variables on the provider' do
      allow(provider).to receive(:refresh_environment_variables)
      resource.refresh
      # assert spy
      expect(provider).to have_received(:refresh_environment_variables).once 
    end
  end
end