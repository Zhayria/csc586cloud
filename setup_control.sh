#!/bin/bash

#generate passwordless SSH
runuser -u zw920902 -- ssh-keygen -q -t rsa -f /users/zw920902/.ssh/id_rsa -N ''
runuser -u zw920902 -- cat /users/zw920902/.ssh/id_rsa.pub >> /users/zw92902/.ssh/authorized_keys


