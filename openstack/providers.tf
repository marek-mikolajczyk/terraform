provider "openstack" {
  user_name   = "admin"
  tenant_name = "admin"
  password    = "1fcb31279f15447a"
  auth_url    = "http://192.168.0.21:5000/v3"
  region      = "RegionOne"
}
