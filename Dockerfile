FROM node:12

WORKDIR /usr/src/app

ENV PORT 8080
ENV HOST 0.0.0.0

COPY ./app/package*.json ./

RUN npm install --only=production

# Nuxtプロジェクトのコードをコンテナにコピー
COPY ./app/ .

# prodビルト、サーバ起動
RUN npm run build
CMD npm start