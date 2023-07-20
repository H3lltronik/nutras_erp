FROM node:20.4.0

WORKDIR /app

COPY ./apps/admin_app/package*.json ./

RUN npm install

CMD [ "npm", "run", "dev", "--", "--host", "0.0.0.0" ]