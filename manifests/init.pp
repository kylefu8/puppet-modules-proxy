# == Class: proxy
class proxy (
  $server      = '',
  $port        = '',
  $proxy_owner = 'root',
  $proxy_group = 'root',
  $proxy_mode  = '644',
){
  case $::osfamily {
    'RedHat': {
       $proxy_path = '/etc/profile.d/proxy.sh'
       $template   = 'proxy/rhel.erb'
    }
    'SuSe': {
       $proxy_path = '/etc/sysconfigy/proxy'
       $template   = 'proxy/suse.erb'
    }
    default: {
      fail("Your $(::osfamily) currently is not supported")
    }
   }
  file { 'proxy_file':
    ensure   => file,
    content  => template($template),
    path     => $proxy_path,
    owner    => $proxy_owner,
    group    => $proxy_group,
    mode     => $proxy_mode,
  }
}
