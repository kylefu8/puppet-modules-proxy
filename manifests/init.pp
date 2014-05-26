# == Class: proxy
class proxy (
  $server        = 'UNSET',
  $port          = 'UNSET',
  $https_server  = 'USE_DEFAULTS',
  $https_port    = 'USE_DEFAULTS',
  $ftp_server    = 'USE_DEFAULTS',
  $ftp_port      = 'USE_DEFAULTS',
  $gopher_server = 'USE_DEFAULTS',
  $gopher_port   = 'USE_DEFAULTS',
  $no_proxy      = 'USE_DEFAULTS',
  $proxy_owner   = 'root',
  $proxy_group   = 'root',
  $proxy_mode    = '644',
){

  validate_array($no_proxy)
  if empty($server) == true { fail ('server is must') }
  if empty($port) == true { fail ('port is must') }
  if is_integer($port) == false { fail( 'port must be integers') }

  $_https_server = $https_server ? {
    'USE_DEFAULTS' => $server,
    default        => $https_server,
  }
  $_https_port = $https_port ? {
    'USE_DEFAULTS' => $port,
    default        => $https_port,
  }
  $_ftp_server = $ftp_server ? {
    'USE_DEFAULTS' => $server,
    default        => $ftp_server,
  }
  $_ftp_port   = $ftp_port ? {
    'USE_DEFAULTS' => $port,
    default        => $ftp_port,
  }
  $_no_proxy   = $no_proxy ? {
    'USE_DEFAULTS' => join([ '127.0.0.1','localhost' ],', '),
    default        => join($no_proxy,', '),
  }

  case $::osfamily {
    'RedHat', 'Debian': {
    $proxy_path = '/etc/profile.d/proxy.sh'
    $template   = 'proxy/common.erb'
  }
    'SuSe': {
    $proxy_path = '/etc/sysconfig/proxy'
    $template   = 'proxy/suse.erb'

    $_gopher_server = $gopher_server ? {
      'USE_DEFAULTS' => $server,
      default        => $gopher_server,
  }
    $_gopher_port   = $gopher_port ? {
      'USE_DEFAULTS' => $port,
      default        => $gopher_port,
  }
    validate_re($_gopher_server, '^http', 'The format has to start with http://')
  }
    default: {
      fail("Your $(::osfamily) currently is not supported")
    }
  }

  #validating variables
  validate_re($server, '^http', 'The format has to start with http://')
  validate_re($_https_server, '^http', 'The format has to start with http://')
  validate_re($_ftp_server, '^http', 'The format has to start with http://')



  #create proxy file
  file { 'proxy_file':
    ensure   => file,
    content  => template($template),
    path     => $proxy_path,
    owner    => $proxy_owner,
    group    => $proxy_group,
    mode     => $proxy_mode,
  }
}
