FROM node AS build
RUN mkdir /app
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:alpine
ENV NGINX_ENTRYPOINT_QUIET_LOGS=1
COPY --from=build /app/public /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
