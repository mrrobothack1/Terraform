Sample GCP

provider "google" {
	credentials= "${file("service-account.json")}"
	project= "terraform-gcp-demo-24012"
	region= "us-central1"
	zone= "us-central1-c"
}

resource "google_compute_instance" "vm_instance" {
	name = "terraform-instance"
	machine_type= "f1-micro"

	book_disk {
		initialize_parms {
			image= "debian-cloud/debian-9"
		}
	}

	networkd_interface {
		network = "${google_compute_network.vpc_network.self_link}"
		acess_config= {

		}
	}
}

resource "google_compute_network" "vpc_network" {
	name= "terraform-network"
	auto_create_subnetworks= "true"
}

