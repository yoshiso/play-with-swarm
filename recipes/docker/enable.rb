include_recipe './attributes.rb'

service 'docker' do
  action [:enable, :start]
end
