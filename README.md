ELK (Elasticsearch, Logstash & Kibana) Vagrant File
=========

Sets up a trusty64 (Ubuntu 14.04) box (with 6GB RAM) with Elasticsearch, Logstash & Kibana and dependencies

Follow installation guide on http://docs.vagrantup.com/v2/installation/index.html to install Vagrant and VirtualBox

run logstash (with filter) manually
```
logstash -f /vagrant/configs-elk/logstashGatling.conf
```

For testing the same file you need to remove it's import history
```
rm ~/.sincedb_*
logstash -f /vagrant/configs-elk/logstashGatling.conf
```

or shorter
```
rm ~/.sincedb_*; logstash -f /vagrant/configs-elk/logstashGatling.conf
```

Initial GROK pattern https://github.com/elasticsearch/logstash/blob/master/patterns/grok-patterns
A handy site to debug custom GROK patterns: http://grokdebug.herokuapp.com/

Access Elasticsearch
===================
```
http://localhost:9200
```

Access Kibana
===================
```
http://localhost:5601
```

Control Vagrant
===================

###### Start box
```Shell
vagrant up
```

###### SSH into box
```Shell
vagrant ssh
```

###### Tear down box
```Shell
vagrant destroy
```

More documentation on http://www.vagrantup.com/