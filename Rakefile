
desc 'Cleans produced image'
task :clean do
	sh 'docker rmi -f coigovpl/puppet-forge-server || true'
	sh 'docker images -q --filter "dangling=true" | xargs docker rmi || true'
end

desc 'Builds an image'
task :build do
	sh 'docker build -t coigovpl/puppet-forge-server .'
end

task :default => [:clean, :build]
