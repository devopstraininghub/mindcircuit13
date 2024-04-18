FROM maven AS buildstage
RUN mkdir /opt/wapp1
WORKDIR /opt/wapp1
COPY . .
RUN mvn clean install 

FROM tomcat 
WORKDIR webapps 
COPY --from=buildstage /opt/wapp1/target/mywebapp-3.1.war .
RUN rm -rf ROOT && mv mywebapp-3.1.war ROOT.war
EXPOSE 8080
