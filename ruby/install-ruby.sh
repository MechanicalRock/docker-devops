#!/usr/bin/env bash

 . /etc/profile.d/rvm.sh
 #source $HOME/.rvm/scripts/rvm

 rvm use --default --install $1

 shift

 if (( $# ))
 then gem install $@
 fi

 rvm cleanup all