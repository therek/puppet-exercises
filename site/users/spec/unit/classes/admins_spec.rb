require 'spec_helper_puppet'

describe 'users::admins', :type => :class do
  let(:params) {{ :admins => ['testadmin'] }}

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
    it {is_expected.to contain_class('users::admins')}
    it {is_expected.to contain_user('testadmin').with_managehome(true)}
    it {is_expected.to contain_file('/home/testadmin/.ssh').with(
      ensure: 'directory',
      mode:   '0700',
      )}
    it {is_expected.to contain_file('/home/testadmin/.ssh/id_rsa.pub').with_ensure('file')}
  end
end
