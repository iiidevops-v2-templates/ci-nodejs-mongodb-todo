FROM dockerhub/library/node:16.20.0-bullseye-slim

COPY app /app
WORKDIR /app
RUN npm install
EXPOSE 8080
CMD node server.js
