function proxy_on() {
  export http_proxy=http://proxy.wifi.uma.es:3128/
  export https_proxy=$http_proxy
  export ftp_proxy=$http_proxy
  export rsync_proxy=$http_proxy
  export HTTP_PROXY=$http_proxy
  export HTTPS_PROXY=$http_proxy
  export FTP_PROXY=$http_proxy
  export RSYNC_PROXY=$http_proxy
  export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
  echo -e "Proxy enviroment variable set."
}

function proxy_off() {
  unset http_proxy
  unset https_proxy
  unset ftp_proxy
  unset rsync_proxy
  unset HTTP_PROXY
  unset HTTPS_PROXY
  unset FTP_PROXY
  unset RSYNC_PROXY
  echo -e "Proxy enviroment variable removed."
}
