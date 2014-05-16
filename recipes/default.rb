#
# Cookbook Name:: package-attrs
# Recipe:: default
#
# Copyright 2014, Gennadiy Filatov
#

package node[ 'nginx-simple' ][ :package ][ :name ] do

    action :install
    options node[ 'nginx-simple' ][ :package ][ :options ] if node[ 'nginx-simple' ][ :package ].has_key?( :options )
    version node[ 'nginx-simple' ][ :package ][ :version ] if node[ 'nginx-simple' ][ :package ].has_key?( :version )

end

service 'nginx' do
    supports :restart => true
    action :start
end

node[ 'nginx-simple' ][ :upstream ].each do |name, list|

    template "/etc/nginx/conf.d/01-upstream-#{name}.conf" do

        source 'upstream.erb'
        mode '0644'
        owner 'root'
        group 'root'
        variables(
            :name => name,
            :nodes => list
        )
        notifies :restart, "service[nginx]", :delayed

    end

end

node[ 'nginx-simple' ][ :server ].each do |entry|

    template "/etc/nginx/conf.d/02-server-#{entry[ :name ]}.conf" do

        source 'server.erb'
        mode '0644'
        owner 'root'
        group 'root'
        variables(
            :entry => entry
        )
        notifies :restart, "service[nginx]", :delayed

    end

end

file "/etc/nginx/sites-enabled/default" do
    action :delete
    notifies :restart, "service[nginx]", :delayed
end

file "/etc/nginx/sites-available/default" do
    action :delete
    notifies :restart, "service[nginx]", :delayed
end
