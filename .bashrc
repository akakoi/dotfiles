# 2012/04/01 森くん作の新コンパイルWS向けbashrcファイル
# Copyright Akihiro.Kakoi<akihiro.kakoi@nts.ricoh.co.jp>

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
alias ll='ls -lF'
alias la='ls -aF'
alias lla='ls -aFl'
alias rm='rm -i'

#for X
USER=`whoami`
export DISPLAY=`last -n 1 $USER|grep kakoi|awk '{print $3}'`:0.0

#for python
#export PYTHONPATH=~/usr/lib/python2.6/site-packages
#export PATH=~/usr/bin:${PATH}

#パスワードをシェルスクリプトに書くのが嫌なので
#シェル関数経由で設定するように変更
proxy_adrs='proxy.ricoh.co.jp'
proxy_port='8080'
export no_proxy="localhost,127.0.0.0/8,*.ricoh.co.jp,10.60.99.0/8"
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
}


#ID パスワード入力　ダイアログを出して入力させる。
function suid_input_diag
{
    echo -n "Login SingleUserID"
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


# for ARM Cross Env
export PATH=${PATH}:/opt/arm-2011.03/bin


# start up
#~/bin/redminenews.py
# suid_input_diag
