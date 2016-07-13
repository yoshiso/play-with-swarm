include_recipe './attributes.rb'

template "#{node['swarm_agent']['systemd_dir']}/swarm-agent.service" do
  source File.expand_path(File.dirname(__FILE__)) + "/templates/swarm-agent.service.erb"
  variables node['swarm_agent']
  mode "755"
  notifies :run, 'execute[systemctl-daemon-reload]', :immediately
  notifies :restart, 'service[swarm-agent]'
end

service 'swarm-agent' do
  action [:enable, :start]
end
