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
#CMD ["nginx", "-g", "daemon off;"]  # why i hashed this ?! good, u should know that every container has it's own default entrypoint and 
# the default entrypoint in this container is running nginx and now i'm editing the default entrypoint and the CMD working as an additional argument to the entrypoint
# so in summary, CMD adding an additional argument to the entrypoint, and if u running diffrent and veryting of things in the entrypoint.sh u shouldn't use CMD in this case  
