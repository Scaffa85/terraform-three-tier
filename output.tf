# Public IP of Bastion
output "bastion_host_public_ip" {
  value = "${aws_instance.bastion_host.public_ip}"
}

# SAS 9.4 Outputs
output "sas-9-4-metadata-ip" {
  value = "${formatlist("%v", aws_instance.metadata-tier.*.private_ip)}"
}

output "sas-9-4-mid-tier-ip" {
  value = "${formatlist("%v", aws_instance.mid-tier.*.private_ip)}"
}

output "sas-9-4-compute-tier-ip" {
  value = "${formatlist("%v", aws_instance.compute-tier.*.private_ip)}"
}

# SAS VIYA Outputs
output "viya-services-tier-ip" {
  value = "${formatlist("%v", aws_instance.viya-services.*.private_ip)}"
}

output "viya-mid-tier-ip" {
  value = "${formatlist("%v", aws_instance.cas-mid-tier.*.private_ip)}"
}

output "viya-worker-tier-ip" {
  value = "${formatlist("%v", aws_instance.cas-worker-tier.*.private_ip)}"
}

# SAS HPAE Outputs

output "hpae-head-ip" {
  value = "${formatlist("%v", aws_instance.hpae-head.*.private_ip)}"
}

output "hpae-worker-ip" {
  value = "${formatlist("%v", aws_instance.hpae-worker-tier.*.private_ip)}"
}
