include_recipe './attributes.rb'

template "#{node['swarm_manager']['systemd_dir']}/swarm-manager.service" do
  source File.expand_path(File.dirname(__FILE__)) + "/templates/swarm-manager.service.erb"
  variables node['swarm_manager']
  mode "755"
  notifies :run, 'execute[systemctl-daemon-reload]', :immediately
  notifies :restart, 'service[swarm-manager]'
end

service 'swarm-manager' do
  action [:enable, :start]
end
