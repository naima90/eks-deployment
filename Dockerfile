FROM nginx:1.31.1-alpine-slim

WORKDIR /app

RUN rm -rf /usr/share/nginx/html/*

COPY /app /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]