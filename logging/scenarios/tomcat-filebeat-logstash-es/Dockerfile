FROM maven:3.6.3-openjdk-11 AS maven_builder
WORKDIR /app/
COPY pom.xml /app
COPY src /app/src/
COPY sql /app/sql
RUN mvn package



FROM tomcat:9.0.43-jdk11-openjdk
WORKDIR $CATALINA_HOME/webapps/
COPY --from=maven_builder /app/target/*.war .
RUN rm -rf ROOT && mv *.war ROOT.war

# install filebeat

RUN apt-get update -y && \ 
 apt-get upgrade -y && \
 apt-get install default-jre -y && \
 wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -  && \
 echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-7.x.list && \
 apt-get update -y
RUN cd / && curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-oss-7.8.1-amd64.deb
RUN cd / && dpkg -i filebeat-oss-7.8.1-amd64.deb


# create evtry point
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x  /entrypoint.sh
COPY filebeat.yml /etc/filebeat/filebeat.yml
ADD ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
CMD [ "/usr/local/bin/entrypoint.sh" ]

