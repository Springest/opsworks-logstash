cookbook_file '/usr/local/bin/gor' do
  source 'gor-linux-amd64'
  owner 'root'
  mode 0700
  action :create
end

template '/usr/local/bin/gor_do' do
  source 'gor_do.erb'
  owner 'root'
  mode 0700
  action :create
end