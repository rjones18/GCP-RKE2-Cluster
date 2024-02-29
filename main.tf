resource "google_service_account" "default" {
  account_id   = "rke2-custom-sa"
  display_name = "Custom SA for VM Instance"
}

resource "google_compute_instance" "master_node" {
  count        = 1
  name         = "rke2-master-node"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts" # Ubuntu 20.04 LTS
      labels = {
        my_label = "value"
      }
    }
  }

  #   // Local SSD disk
  #   scratch_disk {
  #     interface = "NVME"
  #   }

  network_interface {
    network    = "default"
    network_ip = "10.128.0.22"
    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo = "bar"    
  }

  

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}


resource "google_compute_instance" "worker_nodes1" {
  count        = 1 # Deploy 2 VMs
  name         = "rke2-vm-worker-1"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts" # Ubuntu 20.04 LTS
      size  = 20  // Set the boot disk size to 20 GB
      labels = {
        my_label = "value"
      }
    }
  }

  // Local SSD disk
  #   scratch_disk {
  #     interface = "NVME"
  #   }

  network_interface {
    network    = "default"
    network_ip = "10.128.0.25"
    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo = "bar"
  }


  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance" "worker_nodes2" {
  count        = 1 # Deploy 2 VMs
  name         = "rke2-vm-worker-2"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts" # Ubuntu 20.04 LTS
      labels = {
        my_label = "value"
      }
    }
  }

  // Local SSD disk
  #   scratch_disk {
  #     interface = "NVME"
  #   }

  network_interface {
    network    = "default"
    network_ip = "10.128.0.15"
    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo = "bar"
  }

  # metadata_startup_script = <<-EOF
  #   #!/bin/bash
  #   apt-get update
  #   apt-get install -y apache2
  #   echo 'Hello from Apache on Debian!' > /var/www/html/index.html
  # EOF

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}
