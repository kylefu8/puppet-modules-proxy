# This file is being maintained by Puppet.
# DO NOT EDIT
## Path:        Network/Proxy
## Description:
## Type:        yesno
## Default:     no
## Config:      kde,profiles
#
# Enable a generation of the proxy settings to the profile.
# This setting allows to turn the proxy on and off while
# preserving the particular proxy setup.
#
PROXY_ENABLED="yes"

## Type:        string
## Default:     ""
#
# Some programs (e.g. lynx, arena and wget) support proxies, if set in
# the environment.  SuSEconfig can add these environment variables to
# /etc/SuSEconfig/* (sourced by /etc/profile etc.) -
# See http://portal.suse.com/sdb/en/1998/01/lynx_proxy.html for more details.
# Example: HTTP_PROXY="http://proxy.provider.de:3128/"
HTTP_PROXY="<%= server %>:<%= port %>"

## Type:        string
## Default:     ""
#
# Some programs (e.g. lynx, arena and wget) support proxies, if set in
# the environment.  SuSEconfig can add these environment variables to
# /etc/SuSEconfig/* (sourced by /etc/profile etc.) -
# this setting is for https connections
HTTPS_PROXY="<%= https_server %>:<%= https_port_real %>"

## Type:        string
## Default:     ""
#
# Example: FTP_PROXY="http://proxy.provider.de:3128/"
#
FTP_PROXY="<%= ftp_server_real %>:<%= ftp_port_real %>"

## Type:        string
## Default:     ""
#
# Example: GOPHER_PROXY="http://proxy.provider.de:3128/"
#
GOPHER_PROXY="<%= gopher_server_real %>:<%= gopher_port_real %>"

## Type:        string(localhost)
## Default:     localhost
#
# Example: NO_PROXY="www.me.de, do.main, localhost"
#
NO_PROXY="<%= no_proxy_real %>"

