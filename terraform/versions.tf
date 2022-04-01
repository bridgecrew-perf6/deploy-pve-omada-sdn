terraform {
    required_providers {
        proxmox = {
            source = "localhost/telmate/proxmox"
            version = ">=2.9.7"
        }
    }
    required_version = ">= 0.14"
}
