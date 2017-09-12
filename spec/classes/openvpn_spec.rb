require 'spec_helper'

describe 'openvpn' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "openvpn class without any parameters" do
          let(:params) {{
            :ca_crt  => 'foobar',
            :cert    => 'baz',
            :key     => 'example',
            :dh      => 'fake',
            :mode    => 'server',
            :network => '192.168.45.0',
            :netmask => '255.255.255.0',
          }}

          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('openvpn::params') }
          it { is_expected.to contain_class('openvpn::install').that_comes_before('Class[openvpn::config]') }
          it { is_expected.to contain_class('openvpn::config') }
          it { is_expected.to contain_class('openvpn::service').that_subscribes_to('Class[openvpn::config]') }

          it { is_expected.to contain_package('openvpn').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'openvpn class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { is_expected.to contain_package('openvpn') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
