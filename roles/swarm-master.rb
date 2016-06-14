include_recipe "etcd::install"
include_recipe "etcd::enable"

# load attributes
node['etcd'] ||= {}
node['etcd']['name'] = "etcd-#{node['remote_env']['private_ipv4']}"
node['etcd']['listen_client_urls'] = "http://#{node['remote_env']['private_ipv4']}:2379,http://127.0.0.1:2379"
node['etcd']['listen_peer_urls'] = "http://#{node['remote_env']['private_ipv4']}:2380"
node['etcd']['advertise_client_urls'] = "http://#{node['remote_env']['private_ipv4']}:2379"
node['etcd']['initial_advertise_peer_urls'] = "http://#{node['remote_env']['private_ipv4']}:2380"
node['etcd']['heartbeat_interval'] = 500
node['etcd']['election_timeout'] = 2500

node['etcd']['initial_cluster'] =  "etcd-1=http://172.31.3.138:2380,etcd-2=http://172.31.13.32:2380,etcd-3=http://172.31.7.148:2380"
node['etcd']['initial_cluster_token'] = "cluster"

node['etcdctl'] ||= {}
node['etcdctl']['peers'] = "http://172.31.3.138:2379,http://172.31.13.32:2379,http://172.31.7.148:2379"
