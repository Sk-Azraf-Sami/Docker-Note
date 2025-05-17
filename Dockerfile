FROM node:22.14
WORKDIR /app 
COPY package.json . 

# don't need nodemon in production 
ARG NODE_ENV
RUN if [ "$NODE_ENV" = "development" ]; \
    then npm install; \
    else npm install --only=production; \
    fi

COPY . ./
ENV PORT=3000
EXPOSE $PORT
CMD ["node", "index.js"]