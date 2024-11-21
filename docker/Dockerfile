FROM node:18-alpine

WORKDIR /app

COPY package*.json .

RUN npm install

COPY index.js .

RUN chown node:node /app

USER node

CMD [ "node", "index.js" ]
