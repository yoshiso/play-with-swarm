include_recipe './attributes.rb'

execute 'systemctl-daemon-reload' do
  command '/bin/systemctl --system daemon-reload'
  action :nothing
end

execute "install docker" do
  command <<-EOH
cd /tmp
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo 'deb https://apt.dockerproject.org/repo ubuntu-xenial main' > /etc/apt/sources.list.d/docker.list
apt-get install docker-engine=#{node['docker']['version']}~trusty
EOH
  notifies :run, 'execute[systemctl-daemon-reload]', :immediately
  notifies :restart, 'service[docker]'
  not_if "test -e /usr/bin/docker && /usr/bin/docker --version | grep -q '#{node['docker']['version']}' "
end
