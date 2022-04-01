resource "proxmox_lxc" "omada_sdn" {
    hostname = "omada-sdn"
    target_node = var.proxmox_target_node
    ostemplate = "${var.proxmox_lxc_template}"
    password = var.password != "" ? var.password : var.proxmox_password
    memory = var.mem
    cores = 2
    unprivileged = true
    swap = 0
    nameserver = var.nameserver
    start = var.start

    rootfs {
        storage = var.rootfs_storage
        size    = var.rootfs_size
    }

    network {
        name = "eth0"
        bridge = var.network_bridge
        tag = var.network_vlan
        ip = var.network_ip
        gw = var.network_ip != "dhcp" ? var.network_gateway : null
    }

    ssh_public_keys = var.ssh_public_key
}
