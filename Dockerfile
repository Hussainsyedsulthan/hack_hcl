# Use the official Node.js image as the base image
FROM node:16-alpine
# Take the war and copy to webapps of tomcat
WORKDIR /opt/.

