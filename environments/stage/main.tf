provider "google" {
  project = var.project_id
  region  = var.region
}

module "networking" {
  source = "../../modules/networking"

  environment = "stage"
  region      = var.region
  subnets = {
    chile   = "10.1.0.0/24"
  }
}

module "compute" {
  source = "../../modules/compute"

  environment   = "stage"
  vpc_name      = module.networking.vpc_name
  subnet_ids    = module.networking.subnet_ids
  primary_zone  = "${var.region}-a"
  jumpbox_zone  = "${var.region}-a"

  instances = {
    app-vm-1 = {
      machine_type = "e2-medium"
      zone         = "${var.region}-a"
      subnet_key   = "chile"
    }
    app-vm-2 = {
      machine_type = "e2-medium"
      zone         = "${var.region}-a"
      subnet_key   = "Chile"
    }
  }
}

module "database" {
  source = "../../modules/database"

  environment = "stage"
  region      = var.region
  vpc_id      = module.networking.vpc_id

  database_configs = {
    chile = {
      tier = "db-f1-micro"
    }
    peru = {
      tier = "db-f1-micro"
    }
    ecuador = {
      tier = "db-f1-micro"
    }
  }
}

module "load_balancer" {
  source = "../../modules/load_balancer"

  environment       = "stage"
  instance_group_id = module.compute.instance_group_id
}