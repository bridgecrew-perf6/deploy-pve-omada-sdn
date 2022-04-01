provider "proxmox" {
    pm_tls_insecure = true
    pm_api_url = "https://${var.proxmox_hostname}:8006/api2/json"
    pm_user = var.proxmox_username
    pm_password = var.proxmox_password
    pm_parallel = 1
}
