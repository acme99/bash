#!/bin/bash

VMID=211
HOSTNAME=infra02
IPA=192.168.100.74

qm clone 9001 ${VMID} --name ${HOSTNAME} --full
qm set ${VMID} --sshkey /root/.ssh/acme-ed.pub
qm resize ${VMID} scsi0 100G
qm set ${VMID} --ipconfig0 ip=${IPA}/24,gw=192.168.100.101
qm set ${VMID} --cicustom "user=local:snippets/user.yaml,vendor=local:snippets/vendor.yaml"
qm set ${VMID} --agent enabled=1
qm set ${VMID} --nameserver="192.168.100.100 192.168.100.101" --searchdomain "sunfire.ch"
qm set ${VMID} --net0 virtio,bridge=vmbr0,macaddr=16:E2:7A:3F:9C:34
qm start ${VMID}

