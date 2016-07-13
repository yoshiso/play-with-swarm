# load attributes
node['etcd'] ||= {}
node['etcd']['version'] = "2.3.6"
node['etcd']['name'] = "#{node['name']}"
node['etcd']['listen_client_urls'] = "http://#{node['private_ipv4']}:2379,http://127.0.0.1:2379"
node['etcd']['listen_peer_urls'] = "http://#{node['private_ipv4']}:2380"
node['etcd']['advertise_client_urls'] = "http://#{node['private_ipv4']}:2379"
node['etcd']['initial_advertise_peer_urls'] = "http://#{node['private_ipv4']}:2380"
node['etcd']['heartbeat_interval'] = 500
node['etcd']['election_timeout'] = 2500

node['etcd']['initial_cluster'] =  "ec2-01=http://172.31.3.138:2380,ec2-02=http://172.31.13.32:2380,ec2-03=http://172.31.7.148:2380"
node['etcd']['initial_cluster_token'] = "cluster"

node['etcdctl'] ||= {}
node['etcdctl']['peers'] = "http://172.31.3.138:2379,http://172.31.13.32:2379,http://172.31.7.148:2379"


include_recipe "etcd"
include_recipe "etcd::enable"

include_recipe '../recipes/docker/default.rb'
include_recipe '../recipes/docker/enable.rb'

include_recipe '../recipes/swarm-manager/default.rb'
include_recipe '../recipes/swarm-agent/default.rb'
