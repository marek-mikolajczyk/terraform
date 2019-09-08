resource "openstack_compute_keypair_v2" "my-cloud-key" {
  name       = "my-key-terraform"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC1drfjMjjSuwOzecINK3re3+yuf82G7DXp49Qf+BS9LiKB063hs8hhlhzuWO48lc8Ou2B07iUMVws/YhcYrB3eb8m3jRWfQIfhCOP41nyy35hKlLifomTOabiDbvsYw8fjvPS5EEWhbNDzKiMVyf0MXPF3hU6uWNfn3snjfHlOmzqa8Mriv8duJabk7iaIevlKdyQ1VV8IUjvT/WAYozcPvCY7viUeDVQ0/fh2LEw9Go2Beakp2GxTBf4AWonowYwpQdgDm+DoKe0nsVQ9Q4cbDE4leH1dSfyov5IldsZcdNmAodnb2HcJVqO0s2Qod3f5KN9fianZVsDjXzNLWmqR root@DESKTOP-ELIN3G3"
}

resource "openstack_images_image_v2" "cirros" {
  name             = "cirrOS"
  image_source_url = "http://download.cirros-cloud.net/0.4.0/cirros-0.4.0-x86_64-disk.img"
  container_format = "bare"
  disk_format      = "qcow2"
  visibility       = "public" 

  properties = {
    environment= "dev"
  }
}

resource "openstack_compute_secgroup_v2" "secgroup_1" {
  name        = "secgroup_1"
  description = "secgroup_1"

  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

    rule {
    from_port = -1
    to_port = -1
    ip_protocol = "icmp"
    cidr = "0.0.0.0/0"
    }
}

resource "openstack_compute_instance_v2" "test" {
  name            = "test-vm"
  image_name      = "cirrOS"
  flavor_name     = "m1.tiny"
  key_pair        = "${openstack_compute_keypair_v2.my-cloud-key.name}"
  security_groups = ["default", "secgroup_1"]

  network {
    name = "external2-shared"
  }
}
