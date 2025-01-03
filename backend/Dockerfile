FROM node:16

WORKDIR /app

COPY package*.json ./

RUN npm install express mongodb cors

COPY . .

EXPOSE 8080

CMD ["node", "index"]
