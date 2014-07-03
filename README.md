ELK (Elasticsearch, Logstash & Kibana) Vagrant File
=========

Sets up a trusty64 (Ubuntu 14.04) box (with 6GB RAM) with Elasticsearch, Logstash & Kibana and dependencies

Follow installation guide on http://docs.vagrantup.com/v2/installation/index.html to install Vagrant and VirtualBox


Control Vagrant
===================
Access Elasticsearch
```
http://localhost:9200
```

Kibana
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



