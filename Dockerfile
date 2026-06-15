FROM nginx:alpine:3.23.4

WORKDIR /app

RUN rm -rf /usr/share/nginx/html/*

COPY /app /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]