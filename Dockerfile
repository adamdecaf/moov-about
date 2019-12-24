FROM nginx:1.17
USER nginx

# Setup nginx
COPY nginx/nginx.conf /opt/nginx/nginx.conf
COPY nginx/default.conf /opt/nginx/conf.d/default.conf
COPY nginx/metrics /opt/nginx/www/metrics

# Bring over assets / files
COPY index.html /opt/nginx/www/
COPY moov.css /opt/nginx/www/
COPY ./assets/ /opt/nginx/www/assets/

EXPOSE 8080

ENTRYPOINT ["nginx"]
CMD ["-c", "/opt/nginx/nginx.conf"]
