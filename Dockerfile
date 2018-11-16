FROM sonarqube:latest
COPY sonar-scanner-cli-3.2.0.1227-linux.zip /usr/local/
RUN cd /usr/local && unzip -q sonar-scanner-cli-3.2.0.1227-linux.zip
RUN echo "export PATH=$PATH:/usr/local/sonar-scanner-3.2.0.1227-linux/bin" >> ~/.bashrc
RUN /bin/bash -c "source ~/.bashrc"
RUN sed -i "s|#sonar.log.rollingPolicy=time:yyyy-MM-dd|sonar.log.rollingPolicy=size:20MB |g" /opt/sonarqube/conf/sonar.properties
RUN sed -i "s|#sonar.log.maxFiles=7|sonar.log.maxFiles=15 |g" /opt/sonarqube/conf/sonar.properties
