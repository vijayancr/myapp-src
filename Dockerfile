# 1. Use lightweight nginx image
FROM nginx:alpine

# 2. Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

# 3. Copy your website files into nginx directory
COPY . /usr/share/nginx/html/

# 4. Expose port 80
EXPOSE 80

