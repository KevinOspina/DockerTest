FROM node:latest

WORKDIR /app

COPY package.json .
COPY package-lock.json .

RUN npm install
COPY . /app

RUN npm run build --prod

EXPOSE 80

CMD ["npm", "run start"]
