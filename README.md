# Deploy Omada SDN Controller

## Requirements

* [Bolt]
* [Terraform]
* [Proxmox VE]

## Setup

1. Add the Ubuntu 20.04 CT template to *local* storage in Proxmox.

2. Define terraform variables, create `terraform/terraform.tfvars`.
   Example:

       proxmox_hostname = "pve.home.lab"
       proxmox_password = "supersecret"
       proxmox_target_node = "pve"
       network_ip = "192.168.0.21/24"
       network_gateway = "192.168.0.1"
       rootfs_storage = "local-zfs"
       ssh_public_key = <<-EOT
       ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC+wlouoPXELa/8j8rDItiD0LA9fhTOpdZxbTqd8YaA/+NwhcDRU46gBwUY3lL8Su8IRlrdTCsiuUqpF4jVoOxnBjP2CTkeImBRheQFIA61jKa/3iSRWJc12BBF21eL2mjVlbbfoXw1zi/CNhy8Yc4c0XGfHvecC4ZX424vp6wBFwHwhzD+2mVZnAlg1m6d2qUERypIUaaPqxpGXwx020IeBgHECot8g6wMJ+nSFX2vHE4zKL5ZDfK+f2pC3smPbiqXA8GGYaYRpj4FRPDpGTV/A+Y/NFZiDHyUrM8PV6t/o6xObDeo4Turjch3gtz/rZc3YDFVp+sNuQvnlnzBzi6x donotuse
       EOT

## Deploy

    bolt module install
    bolt plan run omada_sdn::deploy --target omada-sdn

[Bolt]: https://puppet.com/open-source/bolt/
[Terraform]: https://terraform.io
[Proxmox VE]: https://www.proxmox.com/en/proxmox-ve
