FROM node:12.2.0-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY public ./public
COPY tsconfig.json logo.svg ./
COPY src ./src

CMD ["npm", "start"]
