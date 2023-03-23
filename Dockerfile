FROM node:alpine as development

ARG WORK_DIR=/var/www/node

WORKDIR ${WORK_DIR}

COPY ./package.json ./

RUN npm install --only=development

COPY ./ ./ 

RUN npm run build

CMD ["npm","run start:dev"]


FROM node:alpine as production

WORKDIR ${WORK_DIR}

COPY ./package.json ./ 

RUN npm install --only=production

COPY ./ ./ 

COPY --from=development ${WORK_DIR}/dist ./dist

RUN npm run build

CMD ["node", "dist/main"]