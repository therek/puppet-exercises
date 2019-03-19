require 'spec_helper_puppet'

describe 'users', :type => :class do
  context 'On RedHat os family' do
    let(:facts) do
      {
        :operatingsystem => 'CentOS',
        :osfamily        => 'RedHat',
        :ipaddress       => '192.168.0.1',
        :puppetversion   => Puppet.version
      }
    end

    it {is_expected.to compile }
    it {is_expected.to contain_class('users')}
    it {is_expected.to contain_class('users::root')}
    it {is_expected.to contain_class('users::admins').with_admins(['jack', 'jill'])}
  end
end
