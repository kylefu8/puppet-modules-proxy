require 'spec_helper'

describe 'proxy' do
 
  ['Debian', 'RedHat' ].each do |system|
     let(:facts) {{ :osfamily => system }}
     
     describe "proxy.sh on #{system}" do
       it { should contain_file('/etc/profile.d/proxy.sh').with({
          'context' => 'template('proxy/common.erb')',
          'path'    => '/etc/profile.d/proxy.sh',
          'owner'   => 'root',
          'group'   => 'root',
          'mode'    => '644',
       )}
       }
         context "params" do
           let(:params) {{
             :server   => 'http://exaplem.com',
             :port     => '8080',
             :no_proxy => '[ '127.0.0.1', 'localhost' ]',
           }}
         end
       end
     end

   dscribe "Suse" do
    let(:facts) {{ :osfamily => SuSE }}
     describe "proxy.sh on #{system}" do
       it { should contain_file('/etc/sysconfig/proxy').with({
          'context' => 'template('proxy/suse.erb')',
          'path'    => '/etc/sysconfig/proxy',
          'owner'   => 'root',
          'group'   => 'root',
          'mode'    => '644',
       })
         context "params" do
           let(:params) {{
             :server   => 'http://exaplem.com',
             :port     => '8080',
             :no_proxy => '[ '127.0.0.1', 'localhost' ]',
           }}
       end
     end
   end

end
