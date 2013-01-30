#!/bin/bash
# authenticated proxy server util.
# author: Akihiro.Kakoi<akihiro.kakoi@gmail.com>


proxy_adrs='proxy.server.address'
proxy_port='8080'
deny_proxy="localhost,127.0.0.0/8,*"

function setproxy
{
    user=$1
    pass=$2
    proxy='http://'$user:$pass@$proxy_adrs':'$proxy_port
    export http_proxy=$proxy
    export ftp_proxy=$proxy
    export https_proxy=$proxy
    export proxy=$proxy
    export HTTP_PROXY=$proxy
    export HTTPS_PROXY=$proxy
    export FTP_PROXY=$proxy
    export no_proxy=$deny_proxy
}

#環境変数勝手に見ていつもプロキシーにつなぎに行く
#困ったちゃんを回避するために、一括解除できるようにする.

function unsetproxy
{
    echo -n "unset your proxy setting."
    export -n http_proxy
    export -n ftp_proxy
    export -n https_proxy
    export -n proxy
    export -n HTTP_PROXY
    export -n HTTPS_PROXY
    export -n FTP_PROXY
    export -n no_proxy
}


#proxy id & pass input dialog
function suid_input_diag
{
    echo -n "proxy server login"
    echo
    echo -n "userid>"
    read INPUT
    echo -n "passwd>"
    stty -echo
    read PASSWD
    stty echo
    echo ""
    setproxy $INPUT $PASSWD
}

