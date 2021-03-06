#
# Cookbook Name:: goiardi
# Recipe:: default
#
# Copyright (C) 2015 Matt Whiteley
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

remote_file '/usr/bin/goiardi' do
  source node['goiardi']['bin']
  mode '0755'
end

directory node['goiardi']['confdir'] do
  mode '0755'
  owner 'root'
  group 'root'
  recursive true
end

%w( lfsdir rundir ).each do |d|
  directory node['goiardi'][d] do
    mode '0700'
    owner 'root'
    group 'root'
    recursive true
  end
end

template node['goiardi']['config'] do
  source 'goiardi.conf.erb'
  mode '0444'
  owner 'root'
  group 'root'
  variables(
    ipaddress: node['goiardi']['ipaddress'],
    port: node['goiardi']['port'],
    hostname: node['goiardi']['hostname'],
    rundir: node['goiardi']['rundir'],
    freeze_interval: node['goiardi']['freeze_interval'],
    obj_max_size: node['goiardi']['obj_max_size'],
    json_req_max_size: node['goiardi']['json_req_max_size'],
    log_file: node['goiardi']['log_file'],
    syslog: node['goiardi']['syslog'],
    log_level: node['goiardi']['log_level'],
    use_mysql: node['goiardi']['use_mysql'],
    mysql_username: node['goiardi']['mysql_username'],
    mysql_password: node['goiardi']['mysql_password'],
    mysql_protocol: node['goiardi']['mysql_protocol'],
    mysql_hostname: node['goiardi']['mysql_hostname'],
    mysql_address: node['goiardi']['mysql_address'],
    mysql_port: node['goiardi']['mysql_port'],
    mysql_dbname: node['goiardi']['mysql_dbname'],
    use_postgresql: node['goiardi']['use_postgresql'],
    postgresql_username: node['goiardi']['postgresql_username'],
    postgresql_password: node['goiardi']['postgresql_password'],
    postgresql_host: node['goiardi']['postgresql_hostname'],
    postgresql_port: node['goiardi']['postgresql_port'],
    postgresql_dbname: node['goiardi']['postgresql_dbname'],
    postgresql_sslmode: node['goiardi']['postgresql_sslmode']
  )
end
