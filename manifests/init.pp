# == Class: proxy
class proxy (
  $server       = '',
  $port         = '',
  $https_server = 'USE_DEFAULTS',
  $https_port   = 'USE_DEFAULTS',
  $ftp_server   = 'USE_DEFAULTS',
  $ftp_port     = 'USE_DEFAULTS',
  $gopher_server = 'USE_DEFAULTS',
  $gopher_port  =  'USE_DEFAULTS',
  $no_proxy     = 'USE_DEFAULTS',
  $proxy_owner  = 'root',
  $proxy_group  = 'root',
  $proxy_mode   = '644',
){
  if $https_server == 'USE_DEFAULTS' {
    $https_server_real = $server
  } else {
    $https_server_real = $https_server
  }
  if $https_port == 'USE_DEFAULTS' {
    $https_port_real = $port
  } else {
    $https_port_real = $https_port
  }
  if $ftp_server == 'USE_DEFAULTS' {
    $ftp_server_real = $server
  } else {
    $ftp_server_real = $ftp_server
  }
  if $ftp_port == 'USE_DEFAULTS' {
    $ftp_port_real = $port
  } else {
    $ftp_port_real = $ftp_port
  }

  if $no_proxy == 'USE_DEFAULTS' {
     $no_proxy_real = join([ '127.0.0.1','localhost' ],", ")
  } else {
     $no_proxy_real = join($no_proxy,", ")
  }
  
  case $::osfamily {
    'RedHat': {
       $proxy_path = '/etc/profile.d/proxy.sh'
       $template   = 'proxy/rhel.erb'
   }
    'SuSe': {
       $proxy_path = '/etc/sysconfig/proxy'
       $template   = 'proxy/suse.erb'
       if $gopher_server == 'USE_DEFAULTS' {
         $gopher_server_real = $server
       } else {
         $gopher_server_real = $gopher_server
       }
       if $gopher_port == 'USE_DEFAULTS' {
         $gopher_port_real = $port
       } else {
         $gopher_port_real = $gopher_port
       }
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
