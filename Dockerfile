# syntax=docker/dockerfile:1
FROM node:14.17.1 as base
WORKDIR /app
# copy just the package.json to specify dependencies
COPY package.json package.json
COPY package-lock.json package-lock.json
#create a builderstage for test
FROM base as test
#clean install dependencies
RUN npm ci
# the command to start our app
COPY . .
#the command to start our app
CMD ["node","run"."test"]
#create a buildstage for production
FROM base as prod
# #clear install production dependencies -ignoring devDependencies
RUN npm i --production

COPY . .
EXPOSE 3000
CMD ["npm","run","start"]
