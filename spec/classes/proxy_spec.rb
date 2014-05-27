require 'spec_helper'

describe 'proxy' do
 
  ['Debian', 'RedHat' ].each do |system|
  describe "proxy.sh on #{system}" do
    let(:facts) {{ :osfamily => system }}
    let(:params) {{
      'server'   => 'http://example.com',
      'port'     => '8080',
      'no_proxy' => [ '127.0.0.1', 'localhost' ],
    }}
    it { should contain_class('proxy') } 
    it { should contain_file('proxy_file').with({
           'ensure'  => 'file',
           'path'    => '/etc/profile.d/proxy.sh',
           'owner'   => 'root',
           'group'   => 'root',
           'mode'    => '644',
       })
    }
  end
end

  describe "Suse" do
    let(:facts) {{ :osfamily => 'SuSe' }}
    let(:params) {{
      'server'   => 'http://example.com',
      'port'     => '8080',
      'no_proxy' => [ '127.0.0.1', 'localhost' ],
    }}
    it { should contain_class('proxy') }
  describe "proxy.sh on SuSE" do
    it { should contain_file('proxy_file').with({
          'ensure'  => 'file',
          'path'    => '/etc/sysconfig/proxy',
          'owner'   => 'root',
          'group'   => 'root',
          'mode'    => '644',
       })
       }
    end
  end
end
