#!/usr/bin/python

import sys
import subprocess
from jinja2 import Template
from ansible import inventory

if len(sys.argv) != 2:
    print 'Usage: ./test.py [hostname]'
    sys.exit(1)

my_hostname = sys.argv[1]
my_groups = []

inv = inventory.Inventory()

if inv.get_host(my_hostname) == None:
    print 'Host not in Inventory'
    sys.exit(1)

for group in inv.get_groups():
    if group.name == 'all' or group.name == 'aws_instances':
        continue

    for host in group.get_hosts():
        if host.name == my_hostname:
            my_groups.append(group.name)

template = Template("""{{ hostname }} ansible_ssh_host=192.168.100.2
{% for group in groups %}
[{{ group }}]
{{ hostname}}
{% endfor %}
""")

out = template.render(hostname = my_hostname, groups = my_groups)
file('/tmp/inventory', 'w').write(out)

print "\033[92mDo you want me to update your hosts file? [y/N]\033[0m"
r = raw_input().lower().strip()

if r == 'y':
    print "\033[92mWhat is the FQDN I should add to the hosts file?\033[0m"
    my_fqdn = raw_input().strip()
    subprocess.call("sudo ansible 127.0.0.1 -m lineinfile -a \"dest=/etc/hosts line='192.168.100.2 %s' regexp=^192.168.100.2\" > /dev/null" % my_fqdn, shell=True)


print "\033[92mTesting investory set up!"
print "\033[92mTest with: \033[1mvagrant up \033[21mor \033[1mvagrant provision"
print "\033[0m"
