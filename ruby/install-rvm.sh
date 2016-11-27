#!/usr/bin/env bash
# gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
# GPG fails to resolve hostname due to DNS resolver issue.
# see:
# https://rvm.io/rvm/security
# https://github.com/protobox/protobox/issues/159
# https://github.com/rvm/rvm/issues/3110#issuecomment-95161168
curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -sSL https://get.rvm.io | bash -s $1
