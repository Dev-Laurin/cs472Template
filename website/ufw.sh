#!/bin/bash

ufw --force disable
ufw --force reset

# logging
ufw logging on

# defaults
ufw default deny outgoing
ufw default deny incoming

# dns
ufw allow out 53/udp

# ntp
ufw allow out proto udp from any port 123 to 216.239.35.4 port 123

# ssh
ufw allow in  22/tcp
ufw allow out 22/tcp

# http/https
ufw allow in  80,443/tcp
ufw allow out 80,443/tcp

# nginx
ufw allow 'Nginx Full'

ufw --force enable

ufw status
