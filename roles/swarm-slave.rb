include_recipe "etcd::install"
include_recipe "etcd::enable"


node['etcd'] ||= {}
node['etcd']['name'] = "etcd-#{node['remote_env']['private_ipv4']}"
node['etcd']['listen_client_urls'] = "http://#{node['remote_env']['private_ipv4']}:2379,http://127.0.0.1:2379"
node['etcd']['initial_cluster'] =  "etcd-172.16.1.1=http://172.16.1.1:2380,etcd-172.16.1.2=http://172.16.1.2:2380,etcd-172.16.1.3=http://172.16.1.3:2380"
node['etcd']['initial_cluster_token'] = "picocluster"
node['etcd']['proxy'] = 'on'

node['etcdctl'] ||= {}
node['etcdctl']['peers'] = "http://172.16.1.1:2379,http://172.16.1.2:2379,http://172.16.1.3:2379"
