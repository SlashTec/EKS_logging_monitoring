FROM nginx
WORKDIR /app
#COPY . /app/

COPY default.conf /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf

RUN curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-oss-7.8.1-amd64.deb
RUN dpkg -i filebeat-oss-7.8.1-amd64.deb

COPY filebeat.yml  /etc/filebeat/filebeat.yml
RUN filebeat modules enable nginx
#RUN filebeat setup               # run this just one time 
#RUN service filebeat start
COPY entrypoint.sh /docker-entrypoint.d/
RUN chmod +x  /docker-entrypoint.d/entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.d/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
