variable "proxmox_hostname" {
    description = "Proxmox API hostname or IP"
    type = string
    default = "localhost"
}

variable "proxmox_target_node" {
    description = "Proxmox node to create resource"
    type = string
    default = "pve"
}

variable "proxmox_username" {
    description = "Proxmox API user"
    type = string
    default = "root@pam"
}

variable "proxmox_password" {
    description = "Proxmox API user password"
    type = string
    sensitive = true
}

variable "proxmox_lxc_template" {
    type = string
    default = "local:vztmpl/ubuntu-20.04-standard_20.04-1_amd64.tar.gz"
}

variable "password" {
    description = "root password"
    type = string
    sensitive = true
    default = null
}

variable "mem" {
    description = "memory allocation"
    type = number
    default = 2048
}

variable "start" {
    description = "start after creation"
    type = bool
    default = true
}

variable "rootfs_storage" {
    description = "rootfs storage backend"
    type = string
    default = "local-lvm"
}

variable "rootfs_size" {
    description = "rootfs size"
    type = string
    default = "4G"
}

variable "network_bridge" {
    description = "network bridge"
    type = string
    default = "vmbr0"
}

variable "network_vlan" {
    description = "network vlan"
    type = string
    default = null
}

variable "network_ip" {
    type = string
}

variable "nameserver" {
    type = string
    default = null
}

variable "network_gateway" {
    type = string
}

variable "ssh_public_key" {
    type = string
    default = null
}
