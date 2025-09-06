# Use Tomcat 9 with JDK 11
FROM tomcat:9.0-jdk11

# Copy the WAR file into Tomcat webapps directory
COPY target/netflix-app.war /usr/local/tomcat/webapps/netflix-app.war

# Expose Tomcat default port
EXPOSE 8080

# Start Tomcat server
CMD ["catalina.sh", "run"]

