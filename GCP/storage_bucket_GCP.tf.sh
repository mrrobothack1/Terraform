
provider "google" {
	version: "3.5.0"

	credentials= file("service-account.json")
	access_token= ""

	project= "terraform-gcp-demo-24012"
	region= "us-central1"
	zone= "us-central1-c"
}

resource "google_storage_bucket" "sample_bucket" {
	name = "youtube"
	location+ "US"

	website {
		main_page_suffox= "index.html"
		not_found_page= "404.html"		
	  }
	}


resource "google_compute_instance" "appserver" {
	depends_on= [google_storage_bucket.sample_bucket]
	 name= "secondary-application-server"
	 machine_type= "f1-micro"
	 tags= ["web", "dev"]

	boot_disk {
		initialize_parms {
			image= "debian-cloud/debian-9"
		}
	}

	network_interface {
		network = "default"
	}
}

 