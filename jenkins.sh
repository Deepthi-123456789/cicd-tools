#!/bin/bash

#resize disk from 20GB to 50GB
sudo growpart /dev/nvme0n1 4

sudo lvextend -L +10G /dev/mapper/RootVG-varVol
sudo lvextend -L +10G /dev/mapper/RootVG-rootVol
lvextend -l +100%FREE /dev/mapper/RootVG-homeVol

xfs_growfs /
xfs_growfs /var
xfs_growfs /home


sudo curl -fL https://pkg.jenkins.io/rpm-stable/jenkins.repo -o /etc/yum.repos.d/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/rpm-stable/jenkins.io-2026.key
# Add required dependencies for the jenkins package
sudo dnf install fontconfig java-21-openjdk -y
sudo dnf install jenkins -y
sudo systemctl daemon-reload
sudo systemctl start jenkins
