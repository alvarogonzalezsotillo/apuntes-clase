#!/bin/bash
URL=http://10.1.0.100/profesores/alvaro/jdk-17.0.12_linux-x64_bin.rpm
wget "$URL"
sudo rpm -ivh jdk-17.0.12_linux-x64_bin.rpm
rm jdk-17.0.12_linux-x64_bin.rpm

