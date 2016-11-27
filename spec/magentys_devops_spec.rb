require "serverspec"
require "docker"

describe "Magentys Devops Container" do
  before(:all) do
    Excon.defaults[:write_timeout] = 300
    Excon.defaults[:read_timeout] = 300
    image = Docker::Image.build_from_dir('.') do |v|
      if (log = JSON.parse(v)) && log.has_key?("stream")
        $stdout.puts log["stream"]
      end
    end

    set :os, family: :debian
    set :backend, :docker
    set :docker_image, image.id
  end
  
  describe file('/etc/profile.d/rvm.sh') do
    it { should exist }
  end
  
  describe "installed packages" do
    describe command("/bin/bash -c '. /etc/profile.d/rvm.sh && bundler --version'") do
      its(:stdout) { should include("1.13") }
    end
    
    describe command("/bin/bash -c '. /etc/profile.d/rvm.sh && ruby --version'") do
      its(:stdout) {should include("2.2.3") }
    end
    
    describe command("/bin/bash -c  '. /etc/profile.d/rvm.sh && gem list'") do
      its(:stdout) { should include 'rvm' }
      its(:stdout) { should include 'bundler' }
      its(:stdout) { should include 'rspec' }
      its(:stdout) { should include 'serverspec' }
      its(:stdout) { should include 'specinfra' }
      its(:stdout) { should include 'net-ssh' }
      its(:stdout) { should include 'rake' }
      its(:stdout) { should include 'serverspec-aws' }
      its(:stdout) { should include 'ansible_spec' }
      its(:stdout) { should include 'netaddr' }
      its(:stdout) { should include 'aws-sdk' }
      its(:stdout) { should include 'ci_reporter_rspec' }
    end
  
  end
  

end