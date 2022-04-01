# Omada SDN Controller on LXC

## Requirements

* [Proxmox] 7
* [Terraform] (tested with v1.1.6)
* [git]
* [go]

## Create Servers

### Configure

Review `variables.tf`.

Create `terraform.tfvars` to override default variable values.
At minimum a proxmox hostname, password, and target must be defined.

For example:

    proxmox_hostname = "myvmserver.local"
    proxmox_password = "supersecret"
    proxmox_target_node = "pve"

The latest release of the [terraform proxmox provider] is 2.9.6, but the
resources require changes that have yet to be merged.

    git clone https://github.com/h0tw1r3/terraform-provider-proxmox -b lxc-rootfs-flags
    cd terraform-provider-proxmox
    make local-dev-install

### Deploy

    terraform init
    terraform apply
