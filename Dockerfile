FROM node
  
EXPOSE 9000

COPY ./ /home/node/app

WORKDIR /home/node/app

VOLUME ["/data"]

RUN ["/usr/local/bin/npm", "install"]

RUN ["/home/node/app/node_modules/.bin/knex", "migrate:latest"]

RUN ["/home/node/app/node_modules/.bin/knex", "seed:run"]

CMD ["/usr/local/bin/npm", "start"]
