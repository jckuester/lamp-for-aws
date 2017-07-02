#!/bin/bash

ssh ubuntu@`terraform output bastion_public_ip` -L 8500:127.0.0.1:8500
