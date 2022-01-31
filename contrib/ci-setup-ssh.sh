#!/usr/bin/env bash
ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ""
chmod 700 ~/.ssh/
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
ssh-keyscan -t rsa localhost >> ~/.ssh/known_hosts
ssh-keyscan -t rsa 127.0.0.1 >> ~/.ssh/known_hosts
chmod 600 ~/.ssh/known_hosts
ls -al ~/.ssh/
ssh localhost ls
ssh 127.0.0.1 ls
