FROM nginx:alpine

# Remove default Nginx welcome page
RUN rm -rf /usr/share/nginx/html/*

# Copy our static app into Nginx's default serving directory
COPY app/ /usr/share/nginx/html/

# Nginx listens on port 80 by default inside the container
EXPOSE 80
