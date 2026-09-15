#!/bin/bash
/usr/sbin/sshd
exec docker-entrypoint.sh "$@"