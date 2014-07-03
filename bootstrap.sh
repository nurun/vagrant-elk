#!/usr/bin/env bash

#variables
elasticsearchVersion="1.2.1"
logstashVersion="1.4.2" #url migth need to be updated manually as it contains a hash
kibanaVersion="3.1.0"



echo "Provision VM START"
echo "=========================================="

#elastic search recomends using Oracle JDK
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update

#install prerequisits
echo Install APT Packages
#sudo apt-get -y install oracle-java7-installer curl unzip
sudo apt-get install -y default-jre-headless curl unzip
# redis-server rabbitmq-server g++ git make
sudo apt-get update

cd /tmp
echo Install elasticsearch \(${elasticsearchVersion}\)
	wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-${elasticsearchVersion}.deb
	sudo dpkg -i elasticsearch-1.2.1.deb
	rm elasticsearch-${elasticsearchVersion}.deb
	#auto start elasticsearch
	sudo update-rc.d elasticsearch defaults 95 10
	#start elasticsearch
	sudo /etc/init.d/elasticsearch start

cd /tmp
echo logstash \(${logstashVersion}\)
	wget https://download.elasticsearch.org/logstash/logstash/packages/debian/logstash_${logstashVersion}-1-2c0f5a1_all.deb
	sudo dpkg -i logstash_${logstashVersion}-1-2c0f5a1_all.deb
	rm logstash_${logstashVersion}-1-2c0f5a1_all.deb

#add logstash environment variables
echo "export PATH=/opt/logstash/bin:\$PATH" >> ~/.bashrc


# /opt/logstash/bin/logstash -e 'input { stdin { } } output { stdout { codec => rubydebug } }'

cd /tmp
echo kibana \(${kibanaVersion}\)
	wget https://download.elasticsearch.org/kibana/kibana/kibana-${kibanaVersion}.zip
	sudo unzip kibana-${kibanaVersion}.zip

	sudo mkdir -p /var/www/kibana
	sudo cp -R kibana-${kibanaVersion}/* /var/www/kibana/
	rm kibana-${kibanaVersion}.zip
	rm -rf kibana-${kibanaVersion}

	



cd /tmp
echo setup nginx
	sudo apt-get -y install nginx

	#nginx Kinbana config	
	wget https://github.com/elasticsearch/kibana/raw/master/sample/nginx.conf
	find nginx.conf -type f -exec sed -i 's/kibana\.myhost\.org/localhost/g' {} \;
	find nginx.conf -type f -exec sed -i 's/\/usr\/share\/kibana3/\/var\/www\/kibana/g' {} \;
	
	sudo cp nginx.conf /etc/nginx/sites-available/default
	sudo service nginx restart

#add activator to environment variables
#echo "export PATH=/home/vagrant/activator-$activatorVersion-minimal:\$PATH" >> ~/.bashrc
#use node as default JavaScript Engine
#echo "export SBT_OPTS=\"\$SBT_OPTS -Dsbt.jse.engineType=Node\"" >> ~/.bashrc

#reset bash
source ~/.bashrc

java -version

echo Installed elasticsearch \(${elasticsearchVersion}\)
echo Installed logstash \(${logstashVersion}\)
echo Installed kibana \(${kibanaVersion}\)

echo ""
echo "Provision VM finished"