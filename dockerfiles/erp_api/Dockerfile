FROM node:20.4.0

RUN userdel -r node

ARG USER_ID

ARG GROUP_ID

RUN addgroup --gid $GROUP_ID h3lltronik

RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID h3lltronik

USER h3lltronik

WORKDIR /api

# Copying ../../package*.json ./ as h3lltronik
COPY --chown=h3lltronik:h3lltronik ../../apps/erp_api/package*.json ./

RUN npm install

RUN chown -R h3lltronik:h3lltronik /api

USER h3lltronik

CMD [ "npm", "run", "start:dev" ]