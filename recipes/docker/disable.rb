include_recipe './attributes.rb'

service 'docker' do
  action [:disable, :stop]
end
