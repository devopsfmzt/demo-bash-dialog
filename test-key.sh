#!/bin/bash

openssl aes-256-cbc -salt -a -e -in name.txt -out encrypted.txt -pass pass:b04e75b0a83d90ea0721035e
