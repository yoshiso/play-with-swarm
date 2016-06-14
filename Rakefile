require 'yaml'

def apply(path)
  node = YAML.load(File.open(path))
             .tap { |n| n['name'] = path.split('/').last.split('.').first }
  file_path = File.join('./tmp', path)
  File.write(file_path, YAML.dump(node))

  ip = node['ip']
  role = node['role']

  puts "apply start for #{path} ip: #{ip}, role: #{role}"
  puts "bundle exec itamae ssh -h #{ip} -u deploy --node-yaml #{file_path} roles/common.rb"
  system "bundle exec itamae ssh -h #{ip} -u deploy --node-yaml #{file_path} roles/common.rb"
  puts "bundle exec itamae ssh -h #{ip} -u deploy --node-yaml #{file_path} roles/#{role}.rb"
  system "bundle exec itamae ssh -h #{ip} -u deploy --node-yaml #{file_path} roles/#{role}.rb"
end


task :apply do
  ARGV.slice(1,ARGV.size).each{|v| task v.to_sym do; end}

  apply("nodes/#{ARGV.last}.yml")

end
