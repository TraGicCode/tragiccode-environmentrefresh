require 'spec_helper'

describe Puppet::Type.type(:refresh_environment).provider(:windows) do
    let(:resource) { Puppet::Type.type(:refresh_environment).new(:provider => :windows, :name => 'after awscli package') }
    let(:provider) { resource.provider }


    it { is_expected.to respond_to(:refresh_environment_variables) }

    describe '#refresh_environment_variables' do
        it 'calls the helper to refresh environment variables' do
            allow(PuppetX::Tragiccode::SystemEnvironment).to receive(:get_machine_environment_variables)
            provider.refresh_environment_variables
            # assert spy
            expect(PuppetX::Tragiccode::SystemEnvironment).to have_received(:get_machine_environment_variables).once 
        end
    end
end