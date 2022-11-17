#!/bin/bash
image=quay.io/ricardoalonsos/rockylinux:latest
podman rmi -f $image
container=$(buildah from $image)
buildah run $container sh -c "dnf update -y --setopt=tsflags=nodocs && dnf clean all"
buildah commit $container $image
podman run --name rockylinux $image
podman export rockylinux > rockylinux.tar
podman rm rockylinux
podman build -t $image . 
podman push $image
rm rockylinux.tar
