FROM nginx:alpine

COPY index.html /usr/share/nginx/html/

RUN echo "Frontend built at ${date}" >> /usr/share/nginx/html/build-info.txt
