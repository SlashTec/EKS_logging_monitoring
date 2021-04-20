# Install Java
sudo apt-get update
sudo apt install openjdk-11-jre-headless
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/
sudo apt  install awscli 

# Install Logstash
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install apt-transport-https -y
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt-get update
sudo apt-get install logstash

# Starts the logstash service
export PATH="/usr/share/logstash/bin:$PATH"
sudo chmod 777 /usr/share/logstash/data
sudo systemctl start logstash.service

# Add JDBC connector
wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.18.tar.gz
sudo tar -xvzf mysql-connector-java-8.0.18.tar.gz
cp mysql-connector-java-8.0.18/mysql-connector-java-8.0.18.jar /usr/share/logstash/logstash-core/lib/jars/

# Get the logstash config
#sudo aws s3 cp s3://dev-quizplus-deployments/logstash/logstash.conf logstash.conf --region us-east-1


# Execute the migration  >>> perefere to run it manually 
#screen -S logstash
screen -d -m  /usr/share/logstash/bin/logstash -f logstash.conf

