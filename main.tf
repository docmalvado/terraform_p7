locals {
  install_apache = file("./install_apache.sh")
}

module "network" {
  source = "github.com/andreslavadoseti/tf_network_module"
  vpc_cidr_block = var.vpc_cidr_block
  snet_extra_bits = var.snet_extra_bits
}

module "vm" {
  source = "github.com/andreslavadoseti/tf_vm_module"
  keyName = var.keyName
  vpc_id = module.network.vpc_id
  subnet_id = module.network.subnet_ids[0]
  user_data = local.install_apache
}